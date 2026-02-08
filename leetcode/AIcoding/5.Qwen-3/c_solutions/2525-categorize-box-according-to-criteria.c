#include <stdio.h>
#include <stdlib.h>
#include <math.h>

char* categorizeBox(long long length, long long width, long long height, int mass) {
    long long volume = length * width * height;
    int isHeavy = (mass >= 100);
    int isBulky = (volume >= 1e9 || length >= 1e6 || width >= 1e6 || height >= 1e6);

    if (isHeavy && isBulky) {
        return "Both";
    } else if (isHeavy) {
        return "Heavy";
    } else if (isBulky) {
        return "Bulky";
    } else {
        return "Neither";
    }
}