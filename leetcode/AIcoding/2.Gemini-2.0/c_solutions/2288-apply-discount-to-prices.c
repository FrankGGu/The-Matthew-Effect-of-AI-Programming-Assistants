#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *discountPrices(char *sentence, int discount) {
    int len = strlen(sentence);
    char *result = (char *)malloc(sizeof(char) * (len * 4 + 1));
    result[0] = '\0';

    char *token = strtok(sentence, " ");
    while (token != NULL) {
        if (token[0] == '$' && strlen(token) > 1) {
            bool is_valid = true;
            for (int i = 1; i < strlen(token); i++) {
                if (token[i] < '0' || token[i] > '9') {
                    is_valid = false;
                    break;
                }
            }
            if (is_valid) {
                long long price = 0;
                for (int i = 1; i < strlen(token); i++) {
                    price = price * 10 + (token[i] - '0');
                }

                double discounted_price = price * (100.0 - discount) / 100.0;
                char discounted_str[100];
                sprintf(discounted_str, "$%.2f", discounted_price);
                strcat(result, discounted_str);
            } else {
                strcat(result, token);
            }
        } else {
            strcat(result, token);
        }

        token = strtok(NULL, " ");
        if (token != NULL) {
            strcat(result, " ");
        }
    }

    return result;
}