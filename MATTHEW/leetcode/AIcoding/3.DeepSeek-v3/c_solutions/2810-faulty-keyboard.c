char* finalString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == 'i') {
            for (int j = 0; j < idx / 2; j++) {
                char temp = result[j];
                result[j] = result[idx - 1 - j];
                result[idx - 1 - j] = temp;
            }
        } else {
            result[idx++] = s[i];
        }
    }

    result[idx] = '\0';
    return result;
}