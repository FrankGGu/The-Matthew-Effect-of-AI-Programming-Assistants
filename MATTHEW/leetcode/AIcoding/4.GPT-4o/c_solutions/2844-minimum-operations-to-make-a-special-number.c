int minimumOperations(char *num) {
    int n = strlen(num);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (num[i] != '0') count++;
    }

    if (count == 0) return 0;

    for (int i = 0; i < n; i++) {
        if (num[i] == '0') continue;
        for (int j = i + 1; j < n; j++) {
            if (num[j] == '0') continue;
            return count - 2;
        }
    }

    return count - 1;
}