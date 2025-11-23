char* decodeString(char* s) {
    int len = strlen(s);
    int capacity = len * 10;
    char* stack = malloc(capacity);
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] != ']') {
            stack[++top] = s[i];
        } else {
            // Extract encoded_string
            int encoded_len = 0;
            while (top >= 0 && stack[top] != '[') {
                top--;
                encoded_len++;
            }
            top--; // Remove '['

            // Extract k
            int k = 0;
            int digit_place = 1;
            while (top >= 0 && stack[top] >= '0' && stack[top] <= '9') {
                k += (stack[top] - '0') * digit_place;
                digit_place *= 10;
                top--;
            }

            // Push decoded string back to stack
            for (int j = 0; j < k; j++) {
                for (int m = 0; m < encoded_len; m++) {
                    stack[++top] = stack[top - encoded_len + 1];
                }
            }
        }
    }

    stack[top + 1] = '\0';
    return stack;
}