#include <stdlib.h>
#include <string.h>

void backtrack(int index, int n, char* current_string, char*** result, int* returnSize) {
    if (index == n) {
        current_string[n] = '\0';
        (*result)[*returnSize] = (char*)malloc((n + 1) * sizeof(char));
        strcpy((*result)[*returnSize], current_string);
        (*returnSize)++;
        return;
    }

    // Option 1: Place '1'
    current_string[index] = '1';
    backtrack(index + 1, n, current_string, result, returnSize);

    // Option 2: Place '0'
    // Can only place '0' if it's the first character or the previous character was '1'
    if (index == 0 || current_string[index - 1] == '1') {
        current_string[index] = '0';
        backtrack(index + 1, n, current_string, result, returnSize);
    }
}

char** generateBinaryStrings(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    // The number of such strings is F(n+2), where F is the Fibonacci sequence
    // (F(0)=0, F(1)=1, F(2)=1, F(3)=2, ...).
    // For n=1, F(3)=2. For n=2, F(4)=3. For n=3, F(5)=5.
    // For N up to 20, F(22) = 17711. An estimate of 20000 is safe for typical constraints.
    int max_strings_estimate = 20000; 

    char** result = (char**)malloc(max_strings_estimate * sizeof(char*));
    char* current_string = (char*)malloc((n + 1) * sizeof(char));

    *returnSize = 0;

    backtrack(0, n, current_string, &result, returnSize);

    free(current_string);

    return result;
}