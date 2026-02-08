#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countValidTimes(char* time) {
    int hour = 0, minute = 0;
    sscanf(time, "%d:%d", &hour, &minute);

    int count = 0;

    for (int h = 0; h < 24; h++) {
        for (int m = 0; m < 60; m++) {
            char t[6];
            sprintf(t, "%02d:%02d", h, m);

            int valid = 1;
            for (int i = 0; i < 5; i++) {
                if (time[i] != '?' && t[i] != time[i]) {
                    valid = 0;
                    break;
                }
            }
            if (valid) count++;
        }
    }

    return count;
}