#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkIfAllOne(string s) {
    for (int i = 0; i < strlen(s); i++) {
        if (s[i] != '1') return false;
    }
    return true;
}

bool checkOnesSegment(char* s) {
    int n = strlen(s);
    int i = 0;

    while (i < n && s[i] == '0') {
        i++;
    }

    while (i < n && s[i] == '1') {
        i++;
    }

    while (i < n && s[i] == '0') {
        i++;
    }

    return i == n;
}

bool checkIfBinaryStringHasAtMostOneSegmentOfOnes(char* s) {
    return checkOnesSegment(s);
}