char* largestInteger(int target, int* A, int ASize) {
    int dp[1001] = {0};
    for (int i = 0; i <= target; i++) {
        for (int j = 0; j < ASize; j++) {
            if (i >= A[j]) {
                dp[i] = dp[i] > dp[i - A[j]] + A[j] ? dp[i] : dp[i - A[j]] + A[j];
            }
        }
    }

    if (dp[target] != target) return "";

    char* result = (char*)malloc(1001 * sizeof(char));
    result[0] = '\0';

    int count[10] = {0};
    for (int i = 0; i < ASize; i++) {
        count[A[i]]++;
    }

    for (int i = 9; i >= 0; i--) {
        while (count[i] > 0 && target >= i) {
            strcat(result, (char[]){i + '0', '\0'});
            target -= i;
            count[i]--;
        }
    }

    return result;
}