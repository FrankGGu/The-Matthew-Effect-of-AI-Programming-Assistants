#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* one[] = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"};
char* ten[] = {"Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
char* twenty[] = {"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
char* thousand[] = {"", "Thousand", "Million", "Billion"};

char* numberToWordsHelper(int num) {
    if (num == 0) {
        return "";
    }
    if (num < 10) {
        return one[num];
    }
    if (num < 20) {
        return ten[num - 10];
    }
    if (num < 100) {
        char *result = (char*)malloc(100 * sizeof(char));
        sprintf(result, "%s %s", twenty[num / 10], one[num % 10]);
        return result;
    }
    if (num < 1000) {
        char *result = (char*)malloc(200 * sizeof(char));
        char *temp = numberToWordsHelper(num % 100);
        if (strlen(temp) > 0) {
            sprintf(result, "%s Hundred %s", one[num / 100], temp);
        } else {
            sprintf(result, "%s Hundred", one[num / 100]);
        }
        free(temp);
        return result;
    }
    return "";
}

char* numberToWords(int num) {
    if (num == 0) {
        return "Zero";
    }

    char *result = (char*)malloc(500 * sizeof(char));
    result[0] = '\0';

    int i = 0;
    while (num > 0) {
        if (num % 1000 != 0) {
            char *temp = numberToWordsHelper(num % 1000);
            if (strlen(result) > 0) {
                if(strlen(temp) > 0){
                    char *new_result = (char*)malloc(500 * sizeof(char));
                    sprintf(new_result, "%s %s %s", temp, thousand[i], result);
                    free(result);
                    result = new_result;
                }
            } else {
                if(strlen(temp) > 0){
                     char *new_result = (char*)malloc(500 * sizeof(char));
                    sprintf(new_result, "%s %s", temp, thousand[i]);
                    free(result);
                    result = new_result;
                }
            }
            free(temp);
        }
        num /= 1000;
        i++;
    }

    char *final_result = (char*)malloc(500 * sizeof(char));
    int index = 0;
    for(int j=0; j<strlen(result); j++){
        if(j == 0 && result[j] == ' '){
            continue;
        }
        if(j > 0 && result[j] == ' ' && result[j-1] == ' '){
            continue;
        }
        final_result[index++] = result[j];
    }
    if(index > 0 && final_result[index-1] == ' '){
        index--;
    }
    final_result[index] = '\0';

    free(result);
    return final_result;
}