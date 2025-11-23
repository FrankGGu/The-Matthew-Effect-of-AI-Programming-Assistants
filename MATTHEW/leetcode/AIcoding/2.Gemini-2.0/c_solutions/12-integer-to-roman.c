#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * intToRoman(int num){
    char *romanMap[] = {"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"};
    int valMap[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    char *result = (char *)malloc(sizeof(char) * 20);
    result[0] = '\0';
    for (int i = 0; i < 13; i++) {
        while (num >= valMap[i]) {
            strcat(result, romanMap[i]);
            num -= valMap[i];
        }
    }
    return result;
}