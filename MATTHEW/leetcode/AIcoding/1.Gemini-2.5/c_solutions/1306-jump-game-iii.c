#include <stdbool.h>
#include <stdlib.h>

bool dfs(int* arr, int arrSize, int currentIdx, bool* visited) {
    if (currentIdx < 0 || currentIdx >= arrSize || visited[currentIdx]) {
        return false;
    }

    if (arr[currentIdx] == 0) {
        return true;
    }

    visited[currentIdx] = true;

    int jumpValue = arr[currentIdx];

    // Try jumping forwards
    if (dfs(arr, arrSize, currentIdx + jumpValue, visited)) {
        return true;
    }

    // Try jumping backwards
    if (dfs(arr, arrSize, currentIdx - jumpValue, visited)) {
        return true;
    }

    return false;
}

bool canReach(int* arr, int arrSize, int start) {
    bool* visited = (bool*)calloc(arrSize, sizeof(bool));
    if (visited == NULL) {
        return false; // Memory allocation failed
    }

    bool result = dfs(arr, arrSize, start, visited);

    free(visited);
    return result;
}