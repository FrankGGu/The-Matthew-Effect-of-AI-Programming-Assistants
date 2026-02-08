/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* isPalindrome(int node, char* s, int** children, int* childrenColSize, int* returnSize, int* result) {
    int* count = (int*)calloc(26, sizeof(int));
    count[s[node] - 'a']++;

    for (int i = 0; i < childrenColSize[node]; i++) {
        int child = children[node][i];
        int* childCount = isPalindrome(child, s, children, childrenColSize, returnSize, result);
        for (int j = 0; j < 26; j++) {
            count[j] += childCount[j];
        }
        free(childCount);
    }

    int odd = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 == 1) {
            odd++;
        }
    }
    result[node] = (odd <= 1) ? 1 : 0;

    return count;
}

int* palindromicPaths(int n, int** edges, int edgesSize, int* edgesColSize, char* s, int* returnSize) {
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    int** children = (int**)malloc(n * sizeof(int*));
    int* childrenColSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        children[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        children[u][childrenColSize[u]++] = v;
    }

    isPalindrome(0, s, children, childrenColSize, returnSize, result);

    for (int i = 0; i < n; i++) {
        free(children[i]);
    }
    free(children);
    free(childrenColSize);

    return result;
}