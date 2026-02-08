int* minOperations(char * boxes, int* returnSize) {
    int n = strlen(boxes);
    int* result = (int*)malloc(n * sizeof(int));
    int leftCount = 0, rightCount = 0, leftOps = 0, rightOps = 0;

    for (int i = 0; i < n; i++) {
        result[i] = leftOps + rightOps;
        if (boxes[i] == '1') {
            leftCount++;
        }
        leftOps += leftCount;
    }

    for (int i = n - 1; i >= 0; i--) {
        if (boxes[i] == '1') {
            rightCount++;
        }
        rightOps += rightCount;
        result[i] += rightOps;
    }

    *returnSize = n;
    return result;
}