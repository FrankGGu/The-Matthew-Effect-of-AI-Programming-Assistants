char* digitSum(char* s, int k) {
    int n = strlen(s);
    while (n > k) {
        char* temp = (char*)malloc((n / k + (n % k ? 1 : 0)) * sizeof(char));
        int idx = 0;
        for (int i = 0; i < n; i += k) {
            int sum = 0;
            for (int j = 0; j < k && i + j < n; j++) {
                sum += s[i + j] - '0';
            }
            temp[idx++] = sum + '0';
        }
        temp[idx] = '\0';
        s = temp;
        n = idx;
    }
    return s;
}