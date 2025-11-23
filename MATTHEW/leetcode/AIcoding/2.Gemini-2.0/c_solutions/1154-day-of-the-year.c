#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dayOfYear(char * date){
    int year = (date[0] - '0') * 1000 + (date[1] - '0') * 100 + (date[2] - '0') * 10 + (date[3] - '0');
    int month = (date[5] - '0') * 10 + (date[6] - '0');
    int day = (date[8] - '0') * 10 + (date[9] - '0');
    int days[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        days[2] = 29;
    }
    int ans = 0;
    for (int i = 1; i < month; i++) {
        ans += days[i];
    }
    ans += day;
    return ans;
}