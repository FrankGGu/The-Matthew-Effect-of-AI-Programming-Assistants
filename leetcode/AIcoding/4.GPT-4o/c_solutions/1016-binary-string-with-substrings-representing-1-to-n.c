bool queryString(char * binary, int n){
    int len = strlen(binary);
    for (int i = 1; i <= n; i++) {
        int num = i;
        char temp[32];
        int j = 0;
        while (num > 0) {
            temp[j++] = (num % 2) + '0';
            num /= 2;
        }
        temp[j] = '\0';
        for (int k = j - 1; k >= 0; k--) {
            if (binary[len - (j - k)] != temp[k]) break;
            if (k == 0) return true;
        }
    }
    return false;
}