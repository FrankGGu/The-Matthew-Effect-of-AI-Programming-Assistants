#include <stdlib.h>
#include <string.h>

char * removeDuplicates(char * s, int k){
    int n = strlen(s);
    if (n < k) {
        char *res = (char *)malloc(n + 1);
        strcpy(res, s);
        return res;
    }

    char *stack_chars = (char *)malloc(sizeof(char) * (n + 1));
    int *stack_counts = (int *)malloc(sizeof(int) * (n + 1));
    int top = -1; // Stack top index

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (top == -1 || stack_chars[top] != current_char) {
            top++;
            stack_chars[top] = current_char;
            stack_counts[top] = 1;
        } else { // stack_chars[top] == current_char
            stack_counts[top]++;
        }

        if (stack_counts[top] == k) {
            top--;
        }
    }

    // Reconstruct the result string
    int result_len = 0;
    for (int i = 0; i <= top; i++) {
        result_len += stack_counts[i];
    }

    char *result = (char *)malloc(sizeof(char) * (result_len + 1));
    int result_idx = 0;
    for (int i = 0; i <= top; i++) {
        for (int j = 0; j < stack_counts[i]; j++) {
            result[result_idx++] = stack_chars[i];
        }
    }
    result[result_idx] = '\0';

    free(stack_chars);
    free(stack_counts);

    return result;
}