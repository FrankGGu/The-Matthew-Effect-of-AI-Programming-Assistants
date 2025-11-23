int* minCosts(int* cost, int costSize, int* returnSize) {
    *returnSize = costSize;
    int* res = (int*)malloc(costSize * sizeof(int));
    res[0] = cost[0];
    for (int i = 1; i < costSize; i++) {
        res[i] = cost[i] + (res[i-1] < cost[i-1] ? res[i-1] : cost[i-1]);
    }
    return res;
}