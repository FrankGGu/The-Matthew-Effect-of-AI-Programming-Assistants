#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCost(char* s, int* cost) {
    int max_cost = 0;
    int current_cost = 0;
    char prev_char = '\0';

    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == prev_char) {
            current_cost += cost[i];
        } else {
            current_cost = cost[i];
            prev_char = s[i];
        }
        if (current_cost > max_cost) {
            max_cost = current_cost;
        }
    }

    return max_cost;
}