int getMinSwaps(char* num, int k) {
    int n = strlen(num);
    char target[n + 1];
    strcpy(target, num);
    for (int i = 0; i < k; i++) {
        int j = n - 1;
        while (j > 0 && target[j - 1] >= target[j]) j--;
        if (j == 0) break;
        int l = n - 1;
        while (target[l] < target[j - 1]) l--;
        char temp = target[j - 1];
        target[j - 1] = target[l];
        target[l] = temp;
        l = n - 1;
        while (j < l) {
            temp = target[j];
            target[j] = target[l];
            target[l] = temp;
            j++;
            l--;
        }
    }
    int swaps = 0;
    for (int i = 0; i < n; i++) {
        if (num[i] != target[i]) {
            int j = i + 1;
            while (num[j] != target[i]) j++;
            while (j > i) {
                char temp = num[j];
                num[j] = num[j - 1];
                num[j - 1] = temp;
                swaps++;
                j--;
            }
        }
    }
    return swaps;
}