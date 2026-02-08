char* getEncryptedString(char* s, int k) {
    int n = strlen(s);
    char* result = (char*)malloc(n + 1);
    for (int i = 0; i < n; i++) {
        result[i] = s[(i + k) % n];
    }
    result[n] = '\0';
    return result;
}