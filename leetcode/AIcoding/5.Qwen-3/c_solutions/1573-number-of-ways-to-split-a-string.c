#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWays(char* s) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            count++;
        }
    }
    if (count % 2 != 0) {
        return 0;
    }
    if (count == 0) {
        return (n - 1) % (1000000007);
    }
    int first = 0;
    int second = 0;
    int total = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            first++;
            if (first == count / 2) {
                second = 0;
            } else if (first == count / 2 + 1) {
                second++;
            }
        }
        if (first == count / 2) {
            total += second;
        }
    }
    return total % (1000000007);
}