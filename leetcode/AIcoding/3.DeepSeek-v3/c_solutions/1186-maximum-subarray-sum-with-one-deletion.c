int maximumSum(int* arr, int arrSize) {
    if (arrSize == 1) return arr[0];

    int *noDelete = (int*)malloc(arrSize * sizeof(int));
    int *oneDelete = (int*)malloc(arrSize * sizeof(int));

    noDelete[0] = arr[0];
    oneDelete[0] = 0;
    int maxSum = arr[0];

    for (int i = 1; i < arrSize; i++) {
        noDelete[i] = (noDelete[i-1] > 0 ? noDelete[i-1] : 0) + arr[i];
        oneDelete[i] = (noDelete[i-1] > oneDelete[i-1] ? noDelete[i-1] : oneDelete[i-1]) + arr[i];
        if (i == 1) oneDelete[i] = arr[i];

        int currentMax = noDelete[i] > oneDelete[i] ? noDelete[i] : oneDelete[i];
        if (currentMax > maxSum) maxSum = currentMax;
    }

    free(noDelete);
    free(oneDelete);
    return maxSum;
}