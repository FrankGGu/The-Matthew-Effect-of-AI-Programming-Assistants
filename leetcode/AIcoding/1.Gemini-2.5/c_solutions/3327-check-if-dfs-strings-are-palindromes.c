#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int numVertices;
    AdjNode** adjLists;
} Graph;

Graph* createGraph(int vertices) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numVertices = vertices;
    graph->adjLists = (AdjNode**)malloc(vertices * sizeof(AdjNode*));
    for (int i = 0; i < vertices; i++) {
        graph->adjLists[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = dest;
    newNode->next = graph->adjLists[src];
    graph->adjLists[src] = newNode;

    newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = src;
    newNode->next = graph->adjLists[dest];
    graph->adjLists[dest] = newNode;
}

char dfsStringBuffer[100005]; 
int dfsStringLen;

void dfs(Graph* graph, int vertex, bool* visited, char* s) {
    visited[vertex] = true;
    dfsStringBuffer[dfsStringLen++] = s[vertex];

    AdjNode* adjList = graph->adjLists[vertex];
    AdjNode* temp = adjList;

    while (temp != NULL) {
        int connectedVertex = temp->dest;
        if (!visited[connectedVertex]) {
            dfs(graph, connectedVertex, visited, s);
        }
        temp = temp->next;
    }
}

bool isPalindrome(char* str, int len) {
    int left = 0;
    int right = len - 1;
    while (left < right) {
        if (str[left] != str[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

void freeGraph(Graph* graph) {
    for (int i = 0; i < graph->numVertices; i++) {
        AdjNode* node = graph->adjLists[i];
        while (node != NULL) {
            AdjNode* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(graph->adjLists);
    free(graph);
}

bool checkDFSStringsArePalindromes(int n, int** edges, int edgesSize, int* edgesColSize, char* s) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfsStringLen = 0; 
            dfs(graph, i, visited, s);
            if (!isPalindrome(dfsStringBuffer, dfsStringLen)) {
                free(visited);
                freeGraph(graph);
                return false;
            }
        }
    }

    free(visited);
    freeGraph(graph);
    return true;
}