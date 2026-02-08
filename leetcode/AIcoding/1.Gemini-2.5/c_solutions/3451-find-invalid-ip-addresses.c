#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

bool isValidSegment(const char* start, const char* end) {
    int len = end - start;
    if (len == 0 || len > 3) {
        return false;
    }

    if (len > 1 && *start == '0') {
        return false;
    }

    int num = 0;
    for (int i = 0; i < len; i++) {
        if (!isdigit(start[i])) {
            return false;
        }
        num = num * 10 + (start[i] - '0');
    }

    return num >= 0 && num <= 255;
}

bool isInvalidIPAddress(char* s) {
    if (s == NULL) {
        return true;
    }

    int n = strlen(s);
    if (n < 7 || n > 15) {
        return true;
    }

    const char* current = s;
    const char* nextDot;

    for (int i = 0; i < 4; i++) {
        nextDot = strchr(current, '.');

        if (i < 3) {
            if (nextDot == NULL) {
                return true;
            }
            if (!isValidSegment(current, nextDot)) {
                return true;
            }
            current = nextDot + 1;
        } else {
            if (nextDot != NULL) {
                return true;
            }
            if (!isValidSegment(current, current + strlen(current))) {
                return true;
            }
        }
    }

    return false;
}