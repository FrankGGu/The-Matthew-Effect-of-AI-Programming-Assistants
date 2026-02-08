#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canReorder(int n, int power) {
    char n_str[11], power_str[11];
    sprintf(n_str, "%d", n);
    sprintf(power_str, "%d", power);

    if (strlen(n_str) != strlen(power_str)) {
        return false;
    }

    int n_counts[10] = {0}, power_counts[10] = {0};
    for (int i = 0; n_str[i] != '\0'; i++) {
        n_counts[n_str[i] - '0']++;
        power_counts[power_str[i] - '0']++;
    }

    for (int i = 0; i < 10; i++) {
        if (n_counts[i] != power_counts[i]) {
            return false;
        }
    }

    return true;
}

bool reorderedPowerOf2(int n) {
    for (int i = 0; i < 31; i++) {
        int power = 1 << i;
        if (canReorder(n, power)) {
            return true;
        }
    }
    return false;
}