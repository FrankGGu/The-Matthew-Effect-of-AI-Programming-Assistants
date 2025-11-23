typedef struct Node Node;

typedef struct {
    Node** nodes;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->nodes = (Node**)malloc(sizeof(Node*) * capacity);
    queue->size = 0;
    queue->capacity = capacity;
    return queue;
}

void enqueue(Queue* queue, Node* node) {
    if (queue->size == queue->capacity) {
        queue->capacity *= 2;
        queue->nodes = (Node**)realloc(queue->nodes, sizeof(Node*) * queue->capacity);
    }
    queue->nodes[queue->size++] = node;
}

Node* dequeue(Queue* queue) {
    if (queue->size == 0) return NULL;
    Node* node = queue->nodes[0];
    for (int i = 1; i < queue->size; i++) {
        queue->nodes[i-1] = queue->nodes[i];
    }
    queue->size--;
    return node;
}

void freeQueue(Queue* queue) {
    free(queue->nodes);
    free(queue);
}

int** levelOrder(Node* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    Queue* queue = createQueue(10000);
    enqueue(queue, root);

    int** result = (int**)malloc(sizeof(int*) * 1000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    while (queue->size > 0) {
        int levelSize = queue->size;
        int* level = (int*)malloc(sizeof(int) * levelSize);

        for (int i = 0; i < levelSize; i++) {
            Node* current = dequeue(queue);
            level[i] = current->val;

            for (int j = 0; j < current->numChildren; j++) {
                enqueue(queue, current->children[j]);
            }
        }

        result[*returnSize] = level;
        (*returnColumnSizes)[*returnSize] = levelSize;
        (*returnSize)++;
    }

    freeQueue(queue);
    return result;
}