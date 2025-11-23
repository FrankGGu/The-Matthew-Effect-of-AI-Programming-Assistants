#include <stdbool.h>

char* categorizeBox(long long length, long long width, long long height, int mass) {
    bool isBulky = false;
    bool isHeavy = false;

    // Check for Bulky criteria
    if (length >= 10000 || width >= 10000 || height >= 10000) {
        isBulky = true;
    }

    // Calculate volume using long long to prevent overflow
    long long volume = length * width * height;
    if (volume >= 1000000000LL) { // 10^9
        isBulky = true;
    }

    // Check for Heavy criteria
    if (mass >= 100) {
        isHeavy = true;
    }

    // Categorize the box based on the flags
    if (isBulky && isHeavy) {
        return "Both";
    } else if (isBulky) {
        return "Bulky";
    } else if (isHeavy) {
        return "Heavy";
    } else {
        return "Neither";
    }
}