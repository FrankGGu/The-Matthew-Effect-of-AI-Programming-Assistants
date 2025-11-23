#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getLucky(char * s, int k) {
    char temp[100] = "";
    for (int i = 0; s[i]; i++) {
        int num = s[i] - 'a' + 1;
        char buffer[10];
        sprintf(buffer, "%d", num);
        strcat(temp, buffer);
    }
    int sum = 0;
    for (int i = 0; temp[i]; i++) {
        sum += temp[i] - '0';
    }
    for (int j = 1; j < k; j++) {
        int new_sum = 0;
        while (sum > 0) {
            new_sum += sum % 10;
            sum /= 10;
        }
        sum = new_sum;
    }
    return sum;
}