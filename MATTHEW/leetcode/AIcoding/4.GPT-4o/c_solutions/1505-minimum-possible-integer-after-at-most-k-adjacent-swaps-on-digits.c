char* minimumInteger(char* num, int k) {
    int n = strlen(num);
    for (int i = 0; i < n; i++) {
        int swaps = 0;
        for (int j = i + 1; j < n && swaps < k; j++) {
            if (num[j] < num[i]) {
                swaps += j - i;
                if (swaps <= k) {
                    char temp = num[i];
                    for (int m = i; m < j; m++) {
                        num[m] = num[m + 1];
                    }
                    num[j - 1] = temp;
                    i--;
                }
            }
        }
    }
    return num;
}