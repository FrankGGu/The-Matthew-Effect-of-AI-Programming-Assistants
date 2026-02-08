#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* applyDiscountToPrices(char* sentence, int discount) {
    int len = strlen(sentence);
    char* result = (char*)malloc((len + 10) * sizeof(char));
    int resultIndex = 0;
    int i = 0;

    while (i < len) {
        if (sentence[i] == ' ') {
            result[resultIndex++] = ' ';
            i++;
            continue;
        }

        int start = i;
        while (i < len && (sentence[i] >= '0' && sentence[i] <= '9' || sentence[i] == '.')) {
            i++;
        }

        if (i > start && (i == len || sentence[i] == ' ')) {
            char numberStr[20];
            int numLen = i - start;
            strncpy(numberStr, &sentence[start], numLen);
            numberStr[numLen] = '\0';

            double price = atof(numberStr);
            double discounted = price * (100.0 - discount) / 100.0;
            char formatted[20];
            sprintf(formatted, "%.2f", discounted);

            for (int j = 0; j < strlen(formatted); j++) {
                result[resultIndex++] = formatted[j];
            }
        } else {
            for (int j = start; j < i; j++) {
                result[resultIndex++] = sentence[j];
            }
        }
    }

    result[resultIndex] = '\0';
    return result;
}