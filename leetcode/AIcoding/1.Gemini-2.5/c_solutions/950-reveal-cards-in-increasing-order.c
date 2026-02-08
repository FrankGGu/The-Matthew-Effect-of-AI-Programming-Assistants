#include <stdlib.h> // For malloc, qsort
#include <stdbool.h> // For bool

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* deckRevealedIncreasing(int* deck, int deckSize, int* returnSize) {
    // Set the return size
    *returnSize = deckSize;

    // Handle edge case for an empty deck (though constraints say deckSize >= 1)
    if (deckSize == 0) {
        return NULL;
    }

    // 1. Sort the input deck in increasing order
    qsort(deck, deckSize, sizeof(int), compare);

    // 2. Allocate memory for the result array
    int* result = (int*)malloc(sizeof(int) * deckSize);
    if (result == NULL) {
        return NULL; // Handle malloc failure
    }

    // 3. Simulate the process using a queue of indices
    // We use a circular array to implement the queue for indices
    int* q_indices = (int*)malloc(sizeof(int) * deckSize);
    if (q_indices == NULL) {
        free(result);
        return NULL; // Handle malloc failure
    }
    int q_head = 0; // Points to the front of the queue
    int q_tail = 0; // Points to the next available slot in the queue
    int q_size = 0; // Current number of elements in the queue

    // Initialize the queue with indices 0 to deckSize-1
    // These indices represent the positions in the 'result' array
    for (int i = 0; i < deckSize; ++i) {
        q_indices[q_tail] = i;
        q_tail = (q_tail + 1) % deckSize;
        q_size++;
    }

    // Fill the result array by simulating the reveal process in reverse
    // We take cards from the sorted 'deck' and place them into the 'result' array
    // at positions determined by the queue
    for (int i = 0; i < deckSize; ++i) {
        // Step 1: Take the top index from the queue (this is where the current smallest card goes)
        int current_idx_to_fill = q_indices[q_head];
        q_head = (q_head + 1) % deckSize;
        q_size--;

        // Place the current smallest card (from sorted 'deck') into the determined position
        result[current_idx_to_fill] = deck[i];

        // Step 2: If there are still indices in the queue, move the next top index to the bottom
        if (q_size > 0) {
            int next_idx_to_move = q_indices[q_head];
            q_head = (q_head + 1) % deckSize;
            q_size--;

            q_indices[q_tail] = next_idx_to_move;
            q_tail = (q_tail + 1) % deckSize;
            q_size++;
        }
    }

    // Free the temporary queue array
    free(q_indices);

    return result;
}