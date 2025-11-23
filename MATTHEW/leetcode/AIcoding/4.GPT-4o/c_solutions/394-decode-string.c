char* decodeString(char* s) {
    int len = strlen(s);
    char* stack = (char*)malloc(len * 2);
    int top = -1;
    char* result = (char*)malloc(len * 100);
    int resultIndex = 0;
    int num = 0;
    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + (s[i] - '0');
        } else if (s[i] == '[') {
            stack[++top] = num;
            num = 0;
            stack[++top] = -1; // Marker for '['
        } else if (s[i] == ']') {
            char temp[1000];
            int tempIndex = 0;
            while (stack[top] != -1) {
                temp[tempIndex++] = result[--resultIndex];
            }
            top--; // Pop the '[' marker
            int repeatCount = stack[top--];
            for (int j = 0; j < repeatCount; j++) {
                for (int k = tempIndex - 1; k >= 0; k--) {
                    result[resultIndex++] = temp[k];
                }
            }
        } else {
            result[resultIndex++] = s[i];
        }
    }
    result[resultIndex] = '\0';
    return result;
}