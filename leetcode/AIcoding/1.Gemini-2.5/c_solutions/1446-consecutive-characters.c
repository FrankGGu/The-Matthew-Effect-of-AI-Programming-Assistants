#include <string.h>
#include <stdlib.h>

int maxPower(char * s){
    if (s == NULL || *s == '\0') {
        return 0;
    }

    int max_power = 1;
    int current_power = 1;
    int n = strlen(s);

    for (int i = 1; i < n; i++) {
        if (s[i] == s[i-1]) {
            current_power++;
        } else {
            current_power = 1;
        }
        if (current_power > max_power) {
            max_power = current_power;
        }
    }

    return max_power;
}