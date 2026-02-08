#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfRounds(char * startTime, char * finishTime){
    int startHour = (startTime[0] - '0') * 10 + (startTime[1] - '0');
    int startMinute = (startTime[3] - '0') * 10 + (startTime[4] - '0');
    int finishHour = (finishTime[0] - '0') * 10 + (finishTime[1] - '0');
    int finishMinute = (finishTime[3] - '0') * 10 + (finishTime[4] - '0');

    int startTotalMinutes = startHour * 60 + startMinute;
    int finishTotalMinutes = finishHour * 60 + finishMinute;

    if (finishTotalMinutes < startTotalMinutes) {
        finishTotalMinutes += 24 * 60;
    }

    int startRounded = (startTotalMinutes + 14) / 15 * 15;
    int finishRounded = finishTotalMinutes / 15 * 15;

    return (finishRounded - startRounded) / 15;
}