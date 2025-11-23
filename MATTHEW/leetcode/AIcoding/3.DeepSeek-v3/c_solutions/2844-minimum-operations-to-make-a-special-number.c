int minimumOperations(char* num) {
    int n = strlen(num);
    int ans = n;
    for (int i = n - 1; i >= 0; i--) {
        if (num[i] == '0') {
            for (int j = i - 1; j >= 0; j--) {
                if (num[j] == '0' || num[j] == '5') {
                    ans = fmin(ans, n - j - 2);
                }
            }
        } else if (num[i] == '5') {
            for (int j = i - 1; j >= 0; j--) {
                if (num[j] == '2' || num[j] == '7') {
                    ans = fmin(ans, n - j - 2);
                }
            }
        }
    }

    int count0 = 0;
    for (int i = 0; i < n; i++) {
        if (num[i] == '0') count0++;
    }
    if (count0 > 0) {
        ans = fmin(ans, n - count0);
    }

    return ans;
}