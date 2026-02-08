typedef struct {
    char* combo;
    struct Node* next;
} Node;

typedef struct {
    Node* front;
    Node* rear;
} Queue;

void initQueue(Queue* q) {
    q->front = q->rear = NULL;
}

int isEmpty(Queue* q) {
    return q->front == NULL;
}

void enqueue(Queue* q, char* combo) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->combo = (char*)malloc(5 * sizeof(char));
    strcpy(newNode->combo, combo);
    newNode->next = NULL;

    if (q->rear == NULL) {
        q->front = q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

char* dequeue(Queue* q) {
    if (isEmpty(q)) return NULL;

    Node* temp = q->front;
    char* combo = temp->combo;
    q->front = q->front->next;

    if (q->front == NULL) {
        q->rear = NULL;
    }

    free(temp);
    return combo;
}

void freeQueue(Queue* q) {
    while (!isEmpty(q)) {
        char* combo = dequeue(q);
        free(combo);
    }
}

int openLock(char** deadends, int deadendsSize, char* target) {
    char start[] = "0000";
    if (strcmp(start, target) == 0) return 0;

    int visited[10000] = {0};
    for (int i = 0; i < deadendsSize; i++) {
        int num = atoi(deadends[i]);
        visited[num] = 1;
    }

    if (visited[0]) return -1;

    Queue q;
    initQueue(&q);
    enqueue(&q, start);
    visited[0] = 1;

    int steps = 0;

    while (!isEmpty(&q)) {
        int size = 0;
        Node* current = q.front;
        while (current != NULL) {
            size++;
            current = current->next;
        }

        for (int i = 0; i < size; i++) {
            char* currentCombo = dequeue(&q);

            if (strcmp(currentCombo, target) == 0) {
                free(currentCombo);
                freeQueue(&q);
                return steps;
            }

            for (int j = 0; j < 4; j++) {
                for (int d = -1; d <= 1; d += 2) {
                    char newCombo[5];
                    strcpy(newCombo, currentCombo);
                    int digit = newCombo[j] - '0';
                    digit = (digit + d + 10) % 10;
                    newCombo[j] = digit + '0';

                    int num = atoi(newCombo);
                    if (!visited[num]) {
                        visited[num] = 1;
                        enqueue(&q, newCombo);
                    }
                }
            }
            free(currentCombo);
        }
        steps++;
    }

    freeQueue(&q);
    return -1;
}