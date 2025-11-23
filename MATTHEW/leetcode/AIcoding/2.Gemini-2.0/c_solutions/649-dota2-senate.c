#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *predictPartyVictory(char * senate) {
    int len = strlen(senate);
    int r_count = 0;
    int d_count = 0;
    for (int i = 0; i < len; i++) {
        if (senate[i] == 'R') {
            r_count++;
        } else {
            d_count++;
        }
    }

    int r_ban = 0;
    int d_ban = 0;
    int i = 0;
    while (r_count > 0 && d_count > 0) {
        if (senate[i % len] == 'R') {
            if (r_ban > 0) {
                r_ban--;
                senate[i % len] = 'X';
                r_count--;
            } else {
                d_ban++;
            }
        } else if (senate[i % len] == 'D') {
            if (d_ban > 0) {
                d_ban--;
                senate[i % len] = 'X';
                d_count--;
            } else {
                r_ban++;
            }
        }
        i++;
    }

    if (r_count > 0) {
        return "Radiant";
    } else {
        return "Dire";
    }
}