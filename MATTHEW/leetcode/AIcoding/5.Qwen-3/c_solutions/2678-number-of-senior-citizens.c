#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSeniors(char** details, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        char* detail = details[i];
        int age = (detail[11] - '0') * 10 + (detail[12] - '0');
        if (age > 60) {
            count++;
        }
    }
    return count;
}