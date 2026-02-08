int* numOfFlowersInBloom(int* bloom, int bloomSize, int* wilt, int wiltSize, int* query, int querySize, int* returnSize) {
    int* result = (int*)malloc(querySize * sizeof(int));
    *returnSize = querySize;
    for (int i = 0; i < querySize; i++) {
        int count = 0;
        for (int j = 0; j < bloomSize; j++) {
            if (bloom[j] <= query[i] && query[i] < wilt[j]) {
                count++;
            }
        }
        result[i] = count;
    }
    return result;
}