#include <string.h>

#define MAX_SENATORS 10000

char* predictPartyVictory(char* senate) {
    int n = strlen(senate);

    int radiant_q[MAX_SENATORS];
    int dire_q[MAX_SENATORS];

    int r_head = 0, r_tail = 0;
    int d_head = 0, d_tail = 0;

    for (int i = 0; i < n; i++) {
        if (senate[i] == 'R') {
            radiant_q[r_tail] = i;
            r_tail = (r_tail + 1) % n;
        } else {
            dire_q[d_tail] = i;
            d_tail = (d_tail + 1) % n;
        }
    }

    while (r_head != r_tail && d_head != d_tail) {
        int r_idx = radiant_q[r_head];
        r_head = (r_head + 1) % n;

        int d_idx = dire_q[d_head];
        d_head = (d_head + 1) % n;

        if (r_idx < d_idx) {
            radiant_q[r_tail] = r_idx + n;
            r_tail = (r_tail + 1) % n;
        } else {
            dire_q[d_tail] = d_idx + n;
            d_tail = (d_tail + 1) % n;
        }
    }

    if (r_head != r_tail) {
        return "Radiant";
    } else {
        return "Dire";
    }
}