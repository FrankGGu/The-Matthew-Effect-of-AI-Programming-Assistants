#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

typedef struct {
    int* data;
    int front;
    int rear;
    int capacity;
    int int_size; 
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->front = 0;
    q->rear = -1;
    q->int_size = 0;
    return q;
}

void enqueue(Queue* q, int item) {
    if (q->int_size == q->capacity) {
        // Queue is full, this indicates an issue or requires resizing.
        // For this problem, N is the max capacity, and we only enqueue unique items.
        return;
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = item;
    q->int_size++;
}

int dequeue(Queue* q) {
    if (q->int_size == 0) {
        // Queue is empty, caller should check with isQueueEmpty
        return -1; 
    }
    int item = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->int_size--;
    return item;
}

bool isQueueEmpty(Queue* q) {
    return q->int_size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

long long maxCandies(int* status, int statusSize, int* candies, int candiesSize,
                     int** keys, int* keysColSize, int keysSize,
                     int** containedBoxes, int* containedBoxesColSize, int containedBoxesSize,
                     int* initialBoxes, int initialBoxesSize) {
    int n = statusSize;
    long long totalCandies = 0;

    // State arrays for each box
    bool opened[n];          // True if box has been fully processed (candies collected, contents extracted)
    bool hasKey[n];          // True if we possess the key for this box
    bool knownBox[n];        // True if we know about this box (either initial or found in another box)
    bool inQueue[n];         // True if box is currently in the queue (openable but not yet processed)
    bool isPendingLocked[n]; // True if box is known, not opened/inQueue, and currently locked (status[i]==0 and !hasKey[i])

    // Initialize all state arrays to false
    memset(opened, false, sizeof(opened));
    memset(hasKey, false, sizeof(hasKey));
    memset(knownBox, false, sizeof(knownBox));
    memset(inQueue, false, sizeof(inQueue));
    memset(isPendingLocked, false, sizeof(isPendingLocked));

    Queue* q = createQueue(n);

    // Initial processing of `initialBoxes`
    for (int i = 0; i < initialBoxesSize; i++) {
        int boxIdx = initialBoxes[i];
        knownBox[boxIdx] = true; // All initial boxes are known

        // If the box is not already processed or in queue
        if (!opened[boxIdx] && !inQueue[boxIdx]) { 
            // A box can be opened if it's initially open (status == 1) or we have its key
            if (status[boxIdx] == 1 || hasKey[boxIdx]) { 
                enqueue(q, boxIdx);
                inQueue[boxIdx] = true;
            } else { 
                // If it's initially closed and we don't have its key, it's pending locked
                isPendingLocked[boxIdx] = true;
            }
        }
    }

    bool madeProgress; // Flag to control the outer loop, indicating if any new action was taken
    do {
        madeProgress = false;

        // Phase 1: Process all boxes currently in the queue (standard BFS traversal)
        while (!isQueueEmpty(q)) {
            int currBox = dequeue(q);
            // At this point, inQueue[currBox] should be true. We don't need to explicitly set it false here
            // as 'opened' flag prevents re-processing and 'inQueue' prevents re-adding.

            if (opened[currBox]) { // Should not happen with correct state management, but good for safety
                continue;
            }
            opened[currBox] = true;
            totalCandies += candies[currBox];
            madeProgress = true; // Opening a box is progress

            // If this box was previously marked as pending locked, it's no longer pending
            isPendingLocked[currBox] = false; 

            // Process keys found in currBox
            for (int i = 0; i < keysColSize[currBox]; i++) {
                int keyIdx = keys[currBox][i];
                if (!hasKey[keyIdx]) { // If this is a newly acquired key
                    hasKey[keyIdx] = true;
                    madeProgress = true; // Acquiring a new key is progress

                    // If the acquired key refers to a box we already know about,
                    // and that box is not yet opened or in queue, try to open it.
                    if (knownBox[keyIdx] && !opened[keyIdx] && !inQueue[keyIdx]) {
                        if (status[keyIdx] == 1 || hasKey[keyIdx]) { // Now openable
                            enqueue(q, keyIdx);
                            inQueue[keyIdx] = true;
                            isPendingLocked[keyIdx] = false; // No longer pending
                        }
                    }
                }
            }

            // Process contained boxes found in currBox
            for (int i = 0; i < containedBoxesColSize[currBox]; i++) {
                int boxIdx = containedBoxes[currBox][i];
                if (!knownBox[boxIdx]) { // If this is a box we just discovered
                    knownBox[boxIdx] = true;
                    madeProgress = true; // Discovering a new box is progress
                }

                // Try to open the box (either newly found or already known)
                // If not already processed or in queue
                if (!opened[boxIdx] && !inQueue[boxIdx]) { 
                    if (status[boxIdx] == 1 || hasKey[boxIdx]) { // If openable now
                        enqueue(q, boxIdx);
                        inQueue[boxIdx] = true;
                        isPendingLocked[boxIdx] = false; // No longer pending
                    } else { 
                        // If not openable now, mark it as pending locked
                        isPendingLocked[boxIdx] = true;
                    }
                }
            }
        }

        // Phase 2: After processing all currently openable boxes, re-evaluate all
        // known but pending locked boxes. Some might now be openable due to newly acquired keys.
        if (madeProgress) { // Only re-evaluate if something new happened in Phase 1
            for (int boxIdx = 0; boxIdx < n; boxIdx++) {
                // If a box is pending locked, not yet opened, and not already in queue
                if (isPendingLocked[boxIdx] && !opened[boxIdx] && !inQueue[boxIdx]) { 
                    if (status[boxIdx] == 1 || hasKey[boxIdx]) { // Now openable
                        enqueue(q, boxIdx);
                        inQueue[boxIdx] = true;
                        isPendingLocked[boxIdx] = false; // No longer pending
                        // madeProgress is already true or will be true in the next iteration if q is not empty
                    }
                }
            }
        }

    } while (madeProgress); // Continue as long as we keep opening new boxes or finding new keys/boxes

    freeQueue(q);

    return totalCandies;
}