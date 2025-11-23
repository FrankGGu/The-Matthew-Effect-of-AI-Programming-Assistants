int kBeauty(int num, int k) {
    if (k == 0) return 0;
    char str[11];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int count = 0;

    for (int i = 0; i <= len - k; i++) {
        int subNum = atoi(str + i);
        if (subNum != 0 && num % subNum == 0) {
            count++;
        }
    }

    return count;
}