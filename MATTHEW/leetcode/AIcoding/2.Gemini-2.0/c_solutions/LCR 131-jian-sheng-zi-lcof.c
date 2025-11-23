#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cutBamboo(int bamboo) {
    if (bamboo <= 1) {
        return 0;
    }
    if (bamboo == 2) {
        return 1;
    }
    if (bamboo == 3) {
        return 2;
    }
    if (bamboo == 4) {
        return 2;
    }
    if (bamboo == 5) {
        return 3;
    }
    if (bamboo == 6) {
        return 3;
    }
    if (bamboo == 7) {
        return 4;
    }
    if (bamboo == 8) {
        return 4;
    }
    if (bamboo == 9) {
        return 4;
    }

    double d_bamboo = (double)bamboo;

    double log_val = log2(d_bamboo);
    int int_log = (int)log_val;

    if (pow(2.0, (double)int_log) == d_bamboo) {
        return int_log;
    } else {
        return int_log + 1;
    }
}