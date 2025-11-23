#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * dayOfTheWeek(int day, int month, int year){
    int t[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
    year -= month < 3;
    int dayIndex = (year + year/4 - year/100 + year/400 + t[month-1] + day) % 7;
    char *days[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
    return days[dayIndex];
}