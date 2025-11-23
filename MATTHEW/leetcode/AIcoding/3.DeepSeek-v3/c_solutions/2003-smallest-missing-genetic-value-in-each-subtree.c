/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* smallestMissingValueSubtree(int* parents, int parentsSize, int* nums, int numsSize, int* returnSize) {
    *returnSize = parentsSize;
    int* res = malloc(parentsSize * sizeof(int));
    for (int i = 0; i < parentsSize; i++) {
        res[i] = 1;
    }

    int node1 = -1;
    for (int i = 0; i < parentsSize; i++) {
        if (nums[i] == 1) {
            node1 = i;
            break;
        }
    }
    if (node1 == -1) {
        return res;
    }

    int* children = calloc(parentsSize, sizeof(int));
    int* next = calloc(parentsSize, sizeof(int));
    for (int i = 1; i < parentsSize; i++) {
        int p = parents[i];
        next[i] = children[p];
        children[p] = i;
    }

    int* visited = calloc(100002, sizeof(int));
    int missing = 1;
    int cur = node1;
    int* stack = malloc(parentsSize * sizeof(int));

    while (cur != -1) {
        int top = 0;
        stack[top++] = cur;
        while (top > 0) {
            int node = stack[--top];
            if (visited[nums[node]] == 0) {
                visited[nums[node]] = 1;
                for (int child = children[node]; child != -1; child = next[child]) {
                    stack[top++] = child;
                }
            }
        }
        while (visited[missing] == 1) {
            missing++;
        }
        res[cur] = missing;
        cur = parents[cur];
    }

    free(children);
    free(next);
    free(visited);
    free(stack);
    return res;
}