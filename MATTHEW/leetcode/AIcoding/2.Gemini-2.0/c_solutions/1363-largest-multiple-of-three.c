#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestMultipleOfThree(int* digits, int digitsSize){
    int sum = 0;
    int count[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        sum = (sum + digits[i]) % 3;
        count[digits[i]]++;
    }

    if (sum != 0) {
        if (sum == 1) {
            if (count[1] > 0) {
                count[1]--;
                digitsSize--;
            } else if (count[4] > 0) {
                count[4]--;
                digitsSize--;
            } else if (count[7] > 0) {
                count[7]--;
                digitsSize--;
            } else {
                int removed = 0;
                for (int i = 2; i <= 8; i += 3) {
                    if (count[i] > 0) {
                        count[i]--;
                        digitsSize--;
                        removed++;
                    }
                    if (removed == 2) break;
                }
                if (removed < 2) {
                  for (int i = 5; i <= 9; i += 3) {
                    if (count[i] > 0) {
                        count[i]--;
                        digitsSize--;
                        removed++;
                    }
                    if (removed == 2) break;
                  }
                }

                if (removed < 2) return "0";
            }
        } else {
            if (count[2] > 0) {
                count[2]--;
                digitsSize--;
            } else if (count[5] > 0) {
                count[5]--;
                digitsSize--;
            } else if (count[8] > 0) {
                count[8]--;
                digitsSize--;
            } else {
                int removed = 0;
                for (int i = 1; i <= 7; i += 3) {
                    if (count[i] > 0) {
                        count[i]--;
                        digitsSize--;
                        removed++;
                    }
                    if (removed == 2) break;
                }
                if (removed < 2) {
                  for (int i = 4; i <= 7; i += 3) {
                    if (count[i] > 0) {
                        count[i]--;
                        digitsSize--;
                        removed++;
                    }
                    if (removed == 2) break;
                  }
                }
                if (removed < 2) return "0";
            }
        }
    }

    if (digitsSize == 0) return "0";

    int *result = (int *)malloc(sizeof(int) * digitsSize);
    int index = 0;
    for (int i = 9; i >= 0; i--) {
        for (int j = 0; j < count[i]; j++) {
            result[index++] = i;
        }
    }

    if (result[0] == 0) return "0";

    char *str = (char *)malloc(sizeof(char) * (digitsSize + 1));
    str[digitsSize] = '\0';
    for (int i = 0; i < digitsSize; i++) {
        str[i] = result[i] + '0';
    }

    free(result);
    return str;
}