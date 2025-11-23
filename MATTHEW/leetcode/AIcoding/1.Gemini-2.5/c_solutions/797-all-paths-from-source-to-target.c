#include <stdlib.h>
#include <string.h>

typedef struct {
    int* path;
    int len;
} Path;

typedef struct {
    Path* paths;
    int count;
    int capacity;
} PathList;

static PathList* globalPathList;
static int* currentPathBuffer;
static int currentPathLen;
static int N_nodes; // Number of nodes in the graph

static void dfs(int u, int** graph, int* graphColSize) {
    // Add current node to the path
    currentPathBuffer[currentPathLen++] = u;

    // If target node is reached
    if (u == N_nodes - 1) {
        // Expand path list if necessary
        if (globalPathList->count == globalPathList->capacity) {
            globalPathList->capacity = globalPathList->capacity == 0 ? 1 : globalPathList->capacity * 2;
            globalPathList->paths = (Path*)realloc(globalPathList->paths, globalPathList->capacity * sizeof(Path));
            if (globalPathList->paths == NULL) {
                // Handle realloc failure
                exit(EXIT_FAILURE);
            }
        }

        // Copy the current path to the result list
        globalPathList->paths[globalPathList->count].path = (int*)malloc(currentPathLen * sizeof(int));
        if (globalPathList->paths[globalPathList->count].path == NULL) {
            // Handle malloc failure
            exit(EXIT_FAILURE);
        }
        memcpy(globalPathList->paths[globalPathList->count].path, currentPathBuffer, currentPathLen * sizeof(int));
        globalPathList->paths[globalPathList->count].len = currentPathLen;
        globalPathList->count++;
    } else {
        // Explore neighbors
        for (int i = 0; i < graphColSize[u]; i++) {
            int v = graph[u][i];
            dfs(v, graph, graphColSize);
        }
    }

    // Backtrack: remove current node from path
    currentPathLen--;
}

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    N_nodes = graphSize;

    // Initialize global path list
    globalPathList = (PathList*)malloc(sizeof(PathList));
    if (globalPathList == NULL) {
        exit(EXIT_FAILURE);
    }
    globalPathList->paths = NULL;
    globalPathList->count = 0;
    globalPathList->capacity = 0;

    // Initialize buffer for current path (max length is N_nodes)
    currentPathBuffer = (int*)malloc(N_nodes * sizeof(int));
    if (currentPathBuffer == NULL) {
        free(globalPathList);
        exit(EXIT_FAILURE);
    }
    currentPathLen = 0;

    // Start DFS from node 0
    dfs(0, graph, graphColSize);

    // Prepare return values for LeetCode
    *returnSize = globalPathList->count;
    *returnColumnSizes = (int*)malloc(globalPathList->count * sizeof(int));
    if (*returnColumnSizes == NULL) {
        // Free paths already allocated
        for (int i = 0; i < globalPathList->count; i++) {
            free(globalPathList->paths[i].path);
        }
        free(globalPathList->paths);
        free(globalPathList);
        free(currentPathBuffer);
        exit(EXIT_FAILURE);
    }

    int** result = (int**)malloc(globalPathList->count * sizeof(int*));
    if (result == NULL) {
        // Free paths already allocated and returnColumnSizes
        for (int i = 0; i < globalPathList->count; i++) {
            free(globalPathList->paths[i].path);
        }
        free(globalPathList->paths);
        free(globalPathList);
        free(currentPathBuffer);
        free(*returnColumnSizes);
        exit(EXIT_FAILURE);
    }

    for (int i = 0; i < globalPathList->count; i++) {
        result[i] = globalPathList->paths[i].path;
        (*returnColumnSizes)[i] = globalPathList->paths[i].len;
    }

    // Clean up temporary global allocations (the actual path data is now owned by 'result')
    free(globalPathList->paths); // Frees the array of Path structs, not the individual paths
    free(globalPathList);
    free(currentPathBuffer);

    return result;
}