#include <stdlib.h>
#include <string.h>

char * getPermutation(int n, int k){
    char *result = (char *)malloc(sizeof(char) * (n + 1));
    result[n] = '\0';

    int factorials[10];
    factorials[0] = 1;
    for (int i = 1; i <= n; i++) {
        factorials[i] = factorials[i - 1] * i;
    }

    k--;

    int numbers[10];
    for (int i = 0; i < n; i++) {
        numbers[i] = i + 1;
    }

    for (int i = 0; i < n; i++) {
        int block_size = factorials[n - 1 - i];
        int index = k / block_size;

        result[i] = (char)(numbers[index] + '0');

        for (int j = index; j < n - 1 - i; j++) {
            numbers[j] = numbers[j + 1];
        }

        k %= block_size;
    }

    return result;
}