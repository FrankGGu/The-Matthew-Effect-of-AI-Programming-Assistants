#include <stdlib.h>
#include <string.h>
#include <stdio.h>

const char* ones[] = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"};
const char* teens[] = {"Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
const char* tens[] = {"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
const char* thousands_scales[] = {"", "Thousand", "Million", "Billion"};

int convertLessThan1000(int num, char* buffer) {
    int written = 0;
    if (num >= 100) {
        written += sprintf(buffer + written, "%s Hundred", ones[num / 100]);
        num %= 100;
        if (num > 0) {
            written += sprintf(buffer + written, " ");
        }
    }
    if (num >= 20) {
        written += sprintf(buffer + written, "%s", tens[num / 10]);
        num %= 10;
        if (num > 0) {
            written += sprintf(buffer + written, " ");
        }
    }
    if (num >= 10) {
        written += sprintf(buffer + written, "%s", teens[num - 10]);
        num = 0;
    }
    if (num > 0) {
        written += sprintf(buffer + written, "%s", ones[num]);
    }
    return written;
}

char* numberToWords(int num) {
    if (num == 0) {
        char* result = (char*)malloc(sizeof(char) * (strlen("Zero") + 1));
        strcpy(result, "Zero");
        return result;
    }

    char* result_buffer = (char*)malloc(sizeof(char) * 500);
    result_buffer[0] = '\0';

    int scale_idx = 0;
    char chunk_buffer[100];

    while (num > 0) {
        int chunk = num % 1000;
        if (chunk > 0) {
            chunk_buffer[0] = '\0';
            convertLessThan1000(chunk, chunk_buffer);

            char temp_buffer[500];
            temp_buffer[0] = '\0';

            strcat(temp_buffer, chunk_buffer);

            if (scale_idx > 0) {
                strcat(temp_buffer, " ");
                strcat(temp_buffer, thousands_scales[scale_idx]);
            }

            if (result_buffer[0] != '\0') {
                strcat(temp_buffer, " ");
                strcat(temp_buffer, result_buffer);
            }
            strcpy(result_buffer, temp_buffer);
        }
        num /= 1000;
        scale_idx++;
    }

    return result_buffer;
}