int maxSum(int** arr, int arrRowSize, int* arrColSizes) {
    int max_sum = INT_MIN;

    for (int i = 0; i < arrRowSize - 2; i++) {
        for (int j = 0; j < arrColSizes[i] - 2; j++) {
            int hourglass_sum = arr[i][j] + arr[i][j+1] + arr[i][j+2] +
                                arr[i+1][j+1] +
                                arr[i+2][j] + arr[i+2][j+1] + arr[i+2][j+2];
            if (hourglass_sum > max_sum) {
                max_sum = hourglass_sum;
            }
        }
    }

    return max_sum;
}