#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    struct TreeNode* node;
    long long index;
} QueueItem;

typedef struct {
    QueueItem* items;
    int front;
    int rear;
    int capacity;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->items = (QueueItem*)malloc(sizeof(QueueItem) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, struct TreeNode* node, long long index) {
    if (q->size == q->capacity) {
        return;
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->items[q->rear].node = node;
    q->items[q->rear].index = index;
    q->size++;
}

QueueItem dequeue(Queue* q) {
    QueueItem item = q->items[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->items);
    free(q);
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int maxWidthOfBinaryTree(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    Queue* q = createQueue(3000); 
    enqueue(q, root, 0LL);

    long long maxWidth = 0;

    while (!isEmpty(q)) {
        int levelSize = q->size;
        long long firstIndex = -1;
        long long lastIndex = -1;

        long long level_start_index = q->items[q->front].index;

        for (int i = 0; i < levelSize; i++) {
            QueueItem current = dequeue(q);
            struct TreeNode* currentNode = current.node;
            long long currentIndex = current.index;

            if (firstIndex == -1) {
                firstIndex = currentIndex;
            }
            lastIndex = currentIndex;

            if (currentNode->left != NULL) {
                enqueue(q, currentNode->left, 2 * (currentIndex - level_start_index));
            }
            if (currentNode->right != NULL) {
                enqueue(q, currentNode->right, 2 * (currentIndex - level_start_index) + 1);
            }
        }
        maxWidth = max(maxWidth, lastIndex - firstIndex + 1);
    }

    freeQueue(q);
    return (int)maxWidth;
}