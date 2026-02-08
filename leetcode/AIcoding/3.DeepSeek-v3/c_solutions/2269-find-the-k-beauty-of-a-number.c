int divisorSubstrings(int num, int k) {
    char str[11];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int count = 0;

    for (int i = 0; i <= len - k; i++) {
        char temp[11] = {0};
        strncpy(temp, str + i, k);
        int n = atoi(temp);
        if (n != 0 && num % n == 0) {
            count++;
        }
    }

    return count;
}