#include <stdlib.h>
#include <stdbool.h>

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int num_nodes;
    AdjNode** adj_list;
} Graph;

void add_edge(Graph* graph, int src, int dest) {
    AdjNode* new_node = (AdjNode*)malloc(sizeof(AdjNode));
    new_node->dest = dest;
    new_node->next = graph->adj_list[src];
    graph->adj_list[src] = new_node;
}

typedef struct QueueNode {
    int data;
    struct QueueNode* next;
} QueueNode;

typedef struct Queue {
    QueueNode* front;
    QueueNode* rear;
    int size;
} Queue;

Queue* create_queue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int data) {
    QueueNode* new_node = (QueueNode*)malloc(sizeof(QueueNode));
    new_node->data = data;
    new_node->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = new_node;
    } else {
        q->rear->next = new_node;
        q->rear = new_node;
    }
    q->size++;
}

int dequeue(Queue* q) {
    if (q->front == NULL) return -1;
    QueueNode* temp = q->front;
    int data = temp->data;
    q->front = q->front->next;
    if (q->front == NULL) {
        q->rear = NULL;
    }
    free(temp);
    q->size--;
    return data;
}

bool is_empty(Queue* q) {
    return q->front == NULL;
}

void free_queue(Queue* q) {
    while (!is_empty(q)) {
        dequeue(q);
    }
    free(q);
}

#define BITSET_ULL_COUNT(N) ((N + 63) / 64)
#define SET_BIT(bitset_arr, bit_idx) (bitset_arr[bit_idx / 64] |= (1ULL << (bit_idx % 64)))
#define GET_BIT(bitset_arr, bit_idx) ((bitset_arr[bit_idx / 64] >> (bit_idx % 64)) & 1ULL)
#define OR_BITSETS(dest_bitset, src_bitset, ull_count) \
    for (int i = 0; i < ull_count; ++i) { \
        dest_bitset[i] |= src_bitset[i]; \
    }

int** getAncestors(int n, int** edges, int edgesSize, int* edgesColSize, int** returnColumnSizes, int* returnSize) {
    *returnSize = n;
    *returnColumnSizes = (int*)malloc(sizeof(int) * n);

    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->num_nodes = n;
    graph->adj_list = (AdjNode**)malloc(sizeof(AdjNode*) * n);
    for (int i = 0; i < n; ++i) {
        graph->adj_list[i] = NULL;
    }

    int* in_degree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(graph, u, v);
        in_degree[v]++;
    }

    int bitset_ull_count = BITSET_ULL_COUNT(n);
    unsigned long long** ancestors_bitsets = (unsigned long long**)malloc(sizeof(unsigned long long*) * n);
    for (int i = 0; i < n; ++i) {
        ancestors_bitsets[i] = (unsigned long long*)calloc(bitset_ull_count, sizeof(unsigned long long));
    }

    Queue* q = create_queue();
    for (int i = 0; i < n; ++i) {
        if (in_degree[i] == 0) {
            enqueue(q, i);
        }
    }

    while (!is_empty(q)) {
        int u = dequeue(q);

        AdjNode* current = graph->adj_list[u];
        while (current != NULL) {
            int v = current->dest;

            SET_BIT(ancestors_bitsets[v], u);

            OR_BITSETS(ancestors_bitsets[v], ancestors_bitsets[u], bitset_ull_count);

            in_degree[v]--;
            if (in_degree[v] == 0) {
                enqueue(q, v);
            }
            current = current->next;
        }
    }

    int** result = (int**)malloc(sizeof(int*) * n);
    for (int i = 0; i < n; ++i) {
        int ancestor_count = 0;
        for (int j = 0; j < n; ++j) {
            if (GET_BIT(ancestors_bitsets[i], j)) {
                ancestor_count++;
            }
        }
        (*returnColumnSizes)[i] = ancestor_count;
        result[i] = (int*)malloc(sizeof(int) * ancestor_count);

        int current_idx = 0;
        for (int j = 0; j < n; ++j) {
            if (GET_BIT(ancestors_bitsets[i], j)) {
                result[i][current_idx++] = j;
            }
        }
    }

    free(in_degree);
    free_queue(q);

    for (int i = 0; i < n; ++i) {
        AdjNode* current = graph->adj_list[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
        free(ancestors_bitsets[i]);
    }
    free(graph->adj_list);
    free(graph);
    free(ancestors_bitsets);

    return result;
}