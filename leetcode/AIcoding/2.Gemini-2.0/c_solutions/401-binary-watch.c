#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** readBinaryWatch(int turnedOn, int* returnSize){
    char ** result = (char **)malloc(sizeof(char *) * 1024);
    *returnSize = 0;

    for (int hour = 0; hour < 12; hour++) {
        for (int minute = 0; minute < 60; minute++) {
            int bits = 0;
            int temp_hour = hour;
            int temp_minute = minute;

            while (temp_hour > 0) {
                bits += (temp_hour & 1);
                temp_hour >>= 1;
            }

            while (temp_minute > 0) {
                bits += (temp_minute & 1);
                temp_minute >>= 1;
            }

            if (bits == turnedOn) {
                result[*returnSize] = (char *)malloc(sizeof(char) * 6);
                sprintf(result[*returnSize], "%d:%02d", hour, minute);
                (*returnSize)++;
            }
        }
    }

    return result;
}