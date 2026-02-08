#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

char* largestMultipleOfThree(int* digits, int digitsSize) {
    int sum = 0;
    for (int i = 0; i < digitsSize; i++) {
        sum += digits[i];
    }

    qsort(digits, digitsSize, sizeof(int), compare);

    if (sum % 3 == 0) {
        if (digits[0] == 0) {
            char* result = (char*)malloc(2 * sizeof(char));
            strcpy(result, "0");
            return result;
        }
        char* result = (char*)malloc((digitsSize + 1) * sizeof(char));
        for (int i = 0; i < digitsSize; i++) {
            result[i] = digits[i] + '0';
        }
        result[digitsSize] = '\0';
        return result;
    }

    int index = -1;
    for (int i = 0; i < digitsSize; i++) {
        if (digits[i] % 3 == sum % 3) {
            index = i;
            break;
        }
    }

    if (index != -1) {
        int* newDigits = (int*)malloc((digitsSize - 1) * sizeof(int));
        int k = 0;
        for (int i = 0; i < digitsSize; i++) {
            if (i != index) {
                newDigits[k++] = digits[i];
            }
        }

        if (newDigits[0] == 0) {
            char* result = (char*)malloc(2 * sizeof(char));
            strcpy(result, "0");
            free(newDigits);
            return result;
        }

        char* result = (char*)malloc((digitsSize) * sizeof(char));
        for (int i = 0; i < digitsSize - 1; i++) {
            result[i] = newDigits[i] + '0';
        }
        result[digitsSize - 1] = '\0';
        free(newDigits);
        return result;
    }

    int count = 0;
    for (int i = 0; i < digitsSize; i++) {
        if (digits[i] % 3 == (3 - sum % 3) % 3) {
            count++;
            if (count == 2) {
                int* newDigits = (int*)malloc((digitsSize - 2) * sizeof(int));
                int k = 0;
                for (int j = 0; j < digitsSize; j++) {
                    if (j != i && j != index) {
                        newDigits[k++] = digits[j];
                    }
                }

                if (newDigits[0] == 0) {
                    char* result = (char*)malloc(2 * sizeof(char));
                    strcpy(result, "0");
                    free(newDigits);
                    return result;
                }

                char* result = (char*)malloc((digitsSize) * sizeof(char));
                for (int j = 0; j < digitsSize - 2; j++) {
                    result[j] = newDigits[j] + '0';
                }
                result[digitsSize - 2] = '\0';
                free(newDigits);
                return result;
            }
        }
    }

    char* result = (char*)malloc(2 * sizeof(char));
    strcpy(result, "0");
    return result;
}