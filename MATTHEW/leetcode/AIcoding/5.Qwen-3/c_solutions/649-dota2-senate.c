#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* predictPartyVictory(char* senate) {
    int n = strlen(senate);
    int s = 0, r = 0;
    int s_count = 0, r_count = 0;
    for (int i = 0; i < n; i++) {
        if (senate[i] == 'R') r_count++;
        else s_count++;
    }
    int i = 0;
    while (s_count > 0 && r_count > 0) {
        if (senate[i] == 'R') {
            if (r > 0) {
                r--;
                s_count--;
            } else {
                r++;
            }
        } else {
            if (s > 0) {
                s--;
                r_count--;
            } else {
                s++;
            }
        }
        i = (i + 1) % n;
    }
    return s_count > 0 ? "Radiant" : "Dire";
}