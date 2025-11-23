int minEqualSum(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < arr1Size; i++) sum1 += arr1[i];
    for (int i = 0; i < arr2Size; i++) sum2 += arr2[i];

    if (sum1 == sum2) return sum1;

    int diff = abs(sum1 - sum2);
    int minSum = sum1 > sum2 ? sum2 : sum1;

    for (int i = 0; i < arr1Size; i++) {
        if (arr1[i] == 0) continue;
        int newSum1 = sum1 - arr1[i];
        int newSum2 = sum2 + arr1[i];
        if (newSum1 == newSum2) {
            return newSum1;
        }
    }

    for (int i = 0; i < arr2Size; i++) {
        if (arr2[i] == 0) continue;
        int newSum2 = sum2 - arr2[i];
        int newSum1 = sum1 + arr2[i];
        if (newSum1 == newSum2) {
            return newSum2;
        }
    }

    return minSum - (diff / 2);
}