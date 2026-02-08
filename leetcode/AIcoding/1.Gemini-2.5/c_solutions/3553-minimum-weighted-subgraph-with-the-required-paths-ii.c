#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

#define INF LLONG_MAX

typedef struct Edge {
    int to;
    int weight;
} Edge;

typedef struct AdjList {
    Edge* edges;
    int count;
    int capacity;
} AdjList;

void init_adj_list(AdjList* list, int initial_capacity) {
    list->edges = (Edge*)malloc(sizeof(Edge) * initial_capacity);
    list->count = 0;
    list->capacity = initial_capacity;
}

void add_edge(AdjList* list, int to, int weight) {
    if (list->count == list->capacity) {
        list->capacity *= 2;
        list->edges = (Edge*)realloc(list->edges, sizeof(Edge) * list->capacity);
    }
    list->edges[list->count].to = to;
    list->edges[list->count].weight = weight;
    list->count++;
}

typedef struct HeapNode {
    int u;
    long long d;
} HeapNode;

HeapNode* heap_array;
int heap_capacity;
int heap_size;

void heap_init(int capacity) {
    heap_array = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap_capacity = capacity;
    heap_size = 0;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(int index) {
    while (index > 0 && heap_array[index].d < heap_array[(index - 1) / 2].d) {
        swap(&heap_array[index], &heap_array[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

void heapify_down(int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int smallest = index;

    if (left < heap_size && heap_array[left].d < heap_array[smallest].d) {
        smallest = left;
    }
    if (right < heap_size && heap_array[right].d < heap_array[smallest].d) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap_array[index], &heap_array[smallest]);
        heapify_down(smallest);
    }
}

void heap_push(HeapNode node) {
    if (heap_size == heap_capacity) {
        heap_capacity *= 2;
        heap_array = (HeapNode*)realloc(heap_array, sizeof(HeapNode) * heap_capacity);
    }
    heap_array[heap_size] = node;
    heapify_up(heap_size);
    heap_size++;
}

HeapNode heap_pop() {
    HeapNode root = heap_array[0];
    heap_array[0] = heap_array[heap_size - 1];
    heap_size--;
    heapify_down(0);
    return root;
}

int heap_is_empty() {
    return heap_size == 0;
}

void heap_free() {
    free(heap_array);
    heap_array = NULL;
    heap_size = 0;
    heap_capacity = 0;
}

void dijkstra(int start_node, int n, AdjList* graph, long long* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = INF;
    }
    dist[start_node] = 0;

    heap_size = 0;
    heap_push((HeapNode){.u = start_node, .d = 0});

    while (!heap_is_empty()) {
        HeapNode current = heap_pop();
        int u = current.u;
        long long d = current.d;

        if (d > dist[u]) {
            continue;
        }

        for (int i = 0; i < graph[u].count; i++) {
            Edge edge = graph[u].edges[i];
            int v = edge.to;
            int weight = edge.weight;

            if (dist[u] != INF && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                heap_push((HeapNode){.u = v, .d = dist[v]});
            }
        }
    }
}

long long minimumWeight(int n, int** edges, int edgesSize, int* edgesColSize, int source1, int source2, int dest) {
    AdjList* adj = (AdjList*)malloc(sizeof(AdjList) * n);
    AdjList* rev_adj = (AdjList*)malloc(sizeof(AdjList) * n);

    for (int i = 0; i < n; i++) {
        init_adj_list(&adj[i], 4);
        init_adj_list(&rev_adj[i], 4);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        add_edge(&adj[u], v, w);
        add_edge(&rev_adj[v], u, w);
    }

    long long* dist1 = (long long*)malloc(sizeof(long long) * n);
    long long* dist2 = (long long*)malloc(sizeof(long long) * n);
    long long* dist3 = (long long*)malloc(sizeof(long long) * n);

    heap_init(n);

    dijkstra(source1, n, adj, dist1);
    dijkstra(source2, n, adj, dist2);
    dijkstra(dest, n, rev_adj, dist3);

    long long min_total_weight = INF;

    for (int i = 0; i < n; i++) {
        if (dist1[i] != INF && dist2[i] != INF && dist3[i] != INF) {
            long long current_total = dist1[i] + dist2[i] + dist3[i];
            if (current_total < min_total_weight) {
                min_total_weight = current_total;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i].edges);
        free(rev_adj[i].edges);
    }
    free(adj);
    free(rev_adj);
    free(dist1);
    free(dist2);
    free(dist3);
    heap_free();

    return (min_total_weight == INF) ? -1 : min_total_weight;
}