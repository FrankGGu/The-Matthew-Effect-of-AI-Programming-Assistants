#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define DRAW 0
#define MOUSE_WIN 1
#define CAT_WIN 2
#define MOUSE_TURN 0
#define CAT_TURN 1

int dp[50][50][2];

int outdegree[50][50][2];

typedef struct {
    int* neighbors;
    int count;
} AdjList;

AdjList* adj_graph;
AdjList* rev_adj_mouse; // For mouse's previous positions
AdjList* rev_adj_cat;   // For cat's previous positions

typedef struct {
    int m, c, t;
} State;

typedef struct {
    State* data;
    int front, rear, size, capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (State*)malloc(sizeof(State) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
}

void enqueue(Queue* q, State s) {
    if (q->size == q->capacity) {
        // In a competitive programming context, if capacity is reached,
        // it usually means a logic error or insufficient capacity.
        // For this problem, N*N*2 states is the max, so capacity should be sufficient.
        return; 
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = s;
    q->size++;
}

State dequeue(Queue* q) {
    State s = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return s;
}

bool isQueueEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
}

int catAndMouse(int n, int** graph, int* graphColSize) {
    // Initialize DP and outdegree arrays
    memset(dp, 0, sizeof(dp)); // All states initially DRAW (unknown)
    memset(outdegree, 0, sizeof(outdegree));

    // Allocate and build adjacency lists
    adj_graph = (AdjList*)malloc(sizeof(AdjList) * n);
    rev_adj_mouse = (AdjList*)malloc(sizeof(AdjList) * n);
    rev_adj_cat = (AdjList*)malloc(sizeof(AdjList) * n);

    for (int i = 0; i < n; i++) {
        adj_graph[i].count = graphColSize[i];
        adj_graph[i].neighbors = (int*)malloc(sizeof(int) * graphColSize[i]);
        memcpy(adj_graph[i].neighbors, graph[i], sizeof(int) * graphColSize[i]);

        rev_adj_mouse[i].count = 0;
        rev_adj_mouse[i].neighbors = (int*)malloc(sizeof(int) * (n - 1)); // Max N-1 neighbors
        rev_adj_cat[i].count = 0;
        rev_adj_cat[i].neighbors = (int*)malloc(sizeof(int) * (n - 1));   // Max N-1 neighbors
    }

    // Build reverse adjacency lists
    for (int u = 0; u < n; u++) {
        for (int i = 0; i < adj_graph[u].count; i++) {
            int v = adj_graph[u].neighbors[i];
            rev_adj_mouse[v].neighbors[rev_adj_mouse[v].count++] = u;
            rev_adj_cat[v].neighbors[rev_adj_cat[v].count++] = u;
        }
    }

    // Initialize outdegrees and queue for BFS
    Queue q;
    initQueue(&q, n * n * 2); // Max possible states (m, c, turn)

    for (int m = 0; m < n; m++) {
        for (int c = 0; c < n; c++) {
            // Cat cannot be in hole 0 (node 0)
            if (c == 0) continue; 

            // Initialize outdegrees for mouse's turn
            outdegree[m][c][MOUSE_TURN] = adj_graph[m].count;

            // Initialize outdegrees for cat's turn: count neighbors excluding hole 0
            for (int i = 0; i < adj_graph[c].count; i++) {
                if (adj_graph[c].neighbors[i] != 0) {
                    outdegree[m][c][CAT_TURN]++;
                }
            }

            // Base cases: mouse wins or cat wins immediately
            if (m == 0) { // Mouse reaches hole 0, mouse wins
                dp[m][c][MOUSE_TURN] = MOUSE_WIN;
                enqueue(&q, (State){m, c, MOUSE_TURN});
                dp[m][c][CAT_TURN] = MOUSE_WIN;
                enqueue(&q, (State){m, c, CAT_TURN});
            } else if (c == m) { // Cat catches mouse, cat wins
                dp[m][c][MOUSE_TURN] = CAT_WIN;
                enqueue(&q, (State){m, c, MOUSE_TURN});
                dp[m][c][CAT_TURN] = CAT_WIN;
                enqueue(&q, (State){m, c, CAT_TURN});
            }
        }
    }

    // BFS loop to propagate results
    while (!isQueueEmpty(&q)) {
        State current_state = dequeue(&q);
        int m = current_state.m;
        int c = current_state.c;
        int turn = current_state.t;
        int winner = dp[m][c][turn];

        if (turn == MOUSE_TURN) { // This state (m, c, MOUSE_TURN) was resolved. Consider predecessor states (m, prev_c, CAT_TURN)
            // A state (m, prev_c, CAT_TURN) could lead to (m, c, MOUSE_TURN) if cat moves prev_c -> c.
            for (int i = 0; i < rev_adj_cat[c].count; i++) {
                int prev_c = rev_adj_cat[c].neighbors[i];
                if (prev_c == 0) continue; // Cat cannot move from hole 0

                if (dp[m][prev_c][CAT_TURN] == DRAW) { // If this predecessor state is not yet resolved
                    if (winner == CAT_WIN) { // If current mouse-turn state (m,c,MOUSE_TURN) is CAT_WIN,
                                             // then cat can force a win from (m, prev_c, CAT_TURN) by moving to c.
                        dp[m][prev_c][CAT_TURN] = CAT_WIN;
                        enqueue(&q, (State){m, prev_c, CAT_TURN});
                    } else { // winner == MOUSE_WIN or DRAW. Cat cannot win by moving to c.
                        outdegree[m][prev_c][CAT_TURN]--;
                        if (outdegree[m][prev_c][CAT_TURN] == 0) { // All cat's moves from (m, prev_c, CAT_TURN) are exhausted and none lead to CAT_WIN
                            dp[m][prev_c][CAT_TURN] = MOUSE_WIN; // Cat loses (mouse wins or draw for mouse)
                            enqueue(&q, (State){m, prev_c, CAT_TURN});
                        }
                    }
                }
            }
        } else { // turn == CAT_TURN. This state (m, c, CAT_TURN) was resolved. Consider predecessor states (prev_m, c, MOUSE_TURN)
            // A state (prev_m, c, MOUSE_TURN) could lead to (m, c, CAT_TURN) if mouse moves prev_m -> m.
            for (int i = 0; i < rev_adj_mouse[m].count; i++) {
                int prev_m = rev_adj_mouse[m].neighbors[i];

                if (dp[prev_m][c][MOUSE_TURN] == DRAW) { // If this predecessor state is not yet resolved
                    if (winner == MOUSE_WIN) { // If current cat-turn state (m,c,CAT_TURN) is MOUSE_WIN,
                                             // then mouse can force a win from (prev_m, c, MOUSE_TURN) by moving to m.
                        dp[prev_m][c][MOUSE_TURN] = MOUSE_WIN;
                        enqueue(&q, (State){prev_m, c, MOUSE_TURN});
                    } else { // winner == CAT_WIN or DRAW. Mouse cannot win by moving to m.
                        outdegree[prev_m][c][MOUSE_TURN]--;
                        if (outdegree[prev_m][c][MOUSE_TURN] == 0) { // All mouse's moves from (prev_m, c, MOUSE_TURN) are exhausted and none lead to MOUSE_WIN
                            dp[prev_m][c][MOUSE_TURN] = CAT_WIN; // Mouse loses (cat wins or draw for cat)
                            enqueue(&q, (State){prev_m, c, MOUSE_TURN});
                        }
                    }
                }
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(adj_graph[i].neighbors);
        free(rev_adj_mouse[i].neighbors);
        free(rev_adj_cat[i].neighbors);
    }
    free(adj_graph);
    free(rev_adj_mouse);
    free(rev_adj_cat);
    freeQueue(&q);

    // The result for the initial state (mouse at 1, cat at 2, mouse's turn)
    return dp[1][2][MOUSE_TURN];
}