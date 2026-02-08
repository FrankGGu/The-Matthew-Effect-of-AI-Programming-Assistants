#include <stdbool.h>

static int timeToMinutes(char* timeStr) {
    int hours = (timeStr[0] - '0') * 10 + (timeStr[1] - '0');
    int minutes = (timeStr[3] - '0') * 10 + (timeStr[4] - '0');
    return hours * 60 + minutes;
}

bool haveConflict(char** event1, char** event2) {
    int s1_minutes = timeToMinutes(event1[0]);
    int e1_minutes = timeToMinutes(event1[1]);
    int s2_minutes = timeToMinutes(event2[0]);
    int e2_minutes = timeToMinutes(event2[1]);

    return s1_minutes <= e2_minutes && s2_minutes <= e1_minutes;
}