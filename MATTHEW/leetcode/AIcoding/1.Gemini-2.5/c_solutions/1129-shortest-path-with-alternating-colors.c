#include <stdlib.h>
#include <limits.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    int node;
    int color; // 0 for red, 1 for blue
} QueueItem;

typedef struct {
    QueueItem* data;
    int head;
    int tail;
    int capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (QueueItem*)malloc(capacity * sizeof(QueueItem));
    q->head = 0;
    q->tail = 0;
    q->capacity = capacity;
}

void enqueue(Queue* q, int node, int color) {
    q->data[q->tail].node = node;
    q->data[q->tail].color = color;
    q->tail++;
}

QueueItem dequeue(Queue* q) {
    return q->data[q->head++];
}

int isQueueEmpty(Queue* q) {
    return q->head == q->tail;
}

void addEdge(AdjNode** head, int val) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = val;
    newNode->next = *head;
    *head = newNode;
}

int* shortestAlternatingPaths(int n, int** redEdges, int redEdgesSize, int* redEdgesColSize, int** blueEdges, int blueEdgesSize, int* blueEdgesColSize) {
    // Adjacency lists for red and blue edges
    AdjNode** adjR = (AdjNode**)malloc(n * sizeof(AdjNode*));
    AdjNode** adjB = (AdjNode**)malloc(n * sizeof(AdjNode*));
    for (int i = 0; i < n; i++) {
        adjR[i] = NULL;
        adjB[i] = NULL;
    }

    // Populate adjacency lists for red edges
    for (int i = 0; i < redEdgesSize; i++) {
        addEdge(&adjR[redEdges[i][0]], redEdges[i][1]);
    }
    // Populate adjacency lists for blue edges
    for (int i = 0; i < blueEdgesSize; i++) {
        addEdge(&adjB[blueEdges[i][0]], blueEdges[i][1]);
    }

    // dist[node][color] stores the shortest path to 'node' ending with an edge of 'color'
    // color 0: red, color 1: blue
    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(2 * sizeof(int));
        dist[i][0] = INT_MAX; // Shortest path to i ending with red
        dist[i][1] = INT_MAX; // Shortest path to i ending with blue
    }

    // Initialize queue for BFS
    Queue q;
    initQueue(&q, n * 2); // Max n*2 states (node, color)

    // Starting node 0 has distance 0 for paths ending with red or blue (conceptually)
    // This allows BFS to explore paths starting with either color from node 0.
    dist[0][0] = 0;
    dist[0][1] = 0;
    enqueue(&q, 0, 0); // Enqueue (node 0, last_edge_color_was_red)
    enqueue(&q, 0, 1); // Enqueue (node 0, last_edge_color_was_blue)

    while (!isQueueEmpty(&q)) {
        QueueItem current = dequeue(&q);
        int u = current.node;
        int prev_color = current.color; // Color of the edge used to reach 'u'
        int d = dist[u][prev_color];

        // If the last edge was red (0), the next edge must be blue (1)
        if (prev_color == 0) {
            AdjNode* curr = adjB[u];
            while (curr != NULL) {
                int v = curr->val;
                if (dist[v][1] > d + 1) { // If a shorter path to 'v' ending with blue is found
                    dist[v][1] = d + 1;
                    enqueue(&q, v, 1);
                }
                curr = curr->next;
            }
        }
        // If the last edge was blue (1), the next edge must be red (0)
        else { // prev_color == 1
            AdjNode* curr = adjR[u];
            while (curr != NULL) {
                int v = curr->val;
                if (dist[v][0] > d + 1) { // If a shorter path to 'v' ending with red is found
                    dist[v][0] = d + 1;
                    enqueue(&q, v, 0);
                }
                curr = curr->next;
            }
        }
    }

    // Prepare the final answer array
    int* ans = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        int min_dist = (dist[i][0] < dist[i][1]) ? dist[i][0] : dist[i][1];
        ans[i] = (min_dist == INT_MAX) ? -1 : min_dist;
    }

    // Free allocated memory
    free(q.data);
    for (int i = 0; i < n; i++) {
        free(dist[i]);
        AdjNode* curr = adjR[i];
        while (curr != NULL) {
            AdjNode* temp = curr;
            curr = curr->next;
            free(temp);
        }
        curr = adjB[i];
        while (curr != NULL) {
            AdjNode* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(dist);
    free(adjR);
    free(adjB);

    return ans;
}