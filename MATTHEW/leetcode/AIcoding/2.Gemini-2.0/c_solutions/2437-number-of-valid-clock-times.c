#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countValidClockTimes(char* time) {
    int count = 1;
    if (time[0] == '?') {
        if (time[1] == '?') {
            count *= 24;
        } else if (time[1] <= '3') {
            count *= 3;
        } else {
            count *= 2;
        }
    } else if (time[1] == '?') {
        if (time[0] == '0' || time[0] == '1') {
            count *= 10;
        } else if (time[0] == '2') {
            count *= 4;
        }
    }

    if (time[3] == '?') {
        if (time[4] == '?') {
            count *= 60;
        } else {
            count *= 6;
        }
    } else if (time[4] == '?') {
        count *= 10;
    }

    return count;
}