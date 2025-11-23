char * generateTheString(int n){
    char* result = (char*)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    if (n % 2 == 1) {
        for (int i = 0; i < n; i++) {
            result[i] = 'a';
        }
    } else {
        for (int i = 0; i < n - 1; i++) {
            result[i] = 'a';
        }
        result[n - 1] = 'b';
    }

    return result;
}