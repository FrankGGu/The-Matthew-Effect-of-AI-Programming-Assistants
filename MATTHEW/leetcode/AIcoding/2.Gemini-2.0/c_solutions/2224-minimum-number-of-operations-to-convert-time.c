#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int convertTime(char * current, char * correct){
    int current_h = (current[0] - '0') * 10 + (current[1] - '0');
    int current_m = (current[3] - '0') * 10 + (current[4] - '0');
    int correct_h = (correct[0] - '0') * 10 + (correct[1] - '0');
    int correct_m = (correct[3] - '0') * 10 + (correct[4] - '0');

    int diff = (correct_h - current_h) * 60 + (correct_m - current_m);
    if (diff < 0) {
        diff += 24 * 60;
    }

    int count = 0;
    count += diff / 60;
    diff %= 60;
    count += diff / 15;
    diff %= 15;
    count += diff / 5;
    diff %= 5;
    count += diff;

    return count;
}