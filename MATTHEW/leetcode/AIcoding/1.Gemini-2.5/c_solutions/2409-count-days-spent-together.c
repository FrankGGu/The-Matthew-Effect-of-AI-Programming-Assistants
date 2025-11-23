#include <string.h>
#include <stdlib.h>

int dateToDayOfYear(char* date_str) {
    int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    char month_str[3];
    char day_str[3];

    month_str[0] = date_str[0];
    month_str[1] = date_str[1];
    month_str[2] = '\0';
    int month = atoi(month_str);

    day_str[0] = date_str[3];
    day_str[1] = date_str[4];
    day_str[2] = '\0';
    int day = atoi(day_str);

    int dayOfYear = 0;
    for (int i = 1; i < month; i++) {
        dayOfYear += daysInMonth[i];
    }
    dayOfYear += day;

    return dayOfYear;
}

int countDaysTogether(char * arriveAlice, char * leaveAlice, char * arriveBob, char * leaveBob){
    int aliceArriveDay = dateToDayOfYear(arriveAlice);
    int aliceLeaveDay = dateToDayOfYear(leaveAlice);
    int bobArriveDay = dateToDayOfYear(arriveBob);
    int bobLeaveDay = dateToDayOfYear(leaveBob);

    int latestArrival = (aliceArriveDay > bobArriveDay) ? aliceArriveDay : bobArriveDay;
    int earliestDeparture = (aliceLeaveDay < bobLeaveDay) ? aliceLeaveDay : bobLeaveDay;

    if (latestArrival > earliestDeparture) {
        return 0;
    } else {
        return earliestDeparture - latestArrival + 1;
    }
}