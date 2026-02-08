#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* numberToWords(int num) {
    if (num == 0) return "Zero";

    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;

    const char* lessThan20[] = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    const char* tens[] = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    const char* thousands[] = {"", "Thousand", "Million", "Billion"};

    int i = 0;
    while (num > 0) {
        int chunk = num % 1000;
        if (chunk != 0) {
            char temp[100] = "";
            if (chunk < 20) {
                strcat(temp, lessThan20[chunk]);
            } else {
                int ten = chunk / 10;
                int one = chunk % 10;
                if (one == 0) {
                    strcat(temp, tens[ten]);
                } else {
                    sprintf(temp, "%s%s", tens[ten], lessThan20[one]);
                }
            }
            if (chunk >= 100) {
                int hundred = chunk / 100;
                sprintf(temp, "%s Hundred%s", lessThan20[hundred], temp);
            }
            if (i > 0) {
                strcat(temp, thousands[i]);
            }
            strcat(result, temp);
            strcat(result, " ");
        }
        num /= 1000;
        i++;
    }

    result[strlen(result) - 1] = '\0';
    return result;
}