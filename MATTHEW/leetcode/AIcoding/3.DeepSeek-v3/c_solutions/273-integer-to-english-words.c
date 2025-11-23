#include <stdlib.h>
#include <string.h>

char *numberToWords(int num) {
    if (num == 0) return "Zero";

    char *belowTwenty[] = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    char *tens[] = {"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    char *thousands[] = {"", "Thousand", "Million", "Billion"};

    char *result = (char *)malloc(256 * sizeof(char));
    result[0] = '\0';

    int i = 0;
    while (num > 0) {
        if (num % 1000 != 0) {
            char temp[256] = "";
            helper(num % 1000, belowTwenty, tens, temp);
            if (i > 0) {
                strcat(temp, " ");
                strcat(temp, thousands[i]);
            }
            if (strlen(result) > 0) {
                strcat(temp, " ");
                strcat(temp, result);
            }
            strcpy(result, temp);
        }
        num /= 1000;
        i++;
    }

    return result;
}

void helper(int num, char **belowTwenty, char **tens, char *result) {
    if (num == 0) return;

    if (num < 20) {
        strcat(result, belowTwenty[num]);
    } else if (num < 100) {
        strcat(result, tens[num / 10]);
        if (num % 10 != 0) {
            strcat(result, " ");
            strcat(result, belowTwenty[num % 10]);
        }
    } else {
        strcat(result, belowTwenty[num / 100]);
        strcat(result, " Hundred");
        if (num % 100 != 0) {
            strcat(result, " ");
            helper(num % 100, belowTwenty, tens, result);
        }
    }
}