#include <stdio.h>
#include <stdlib.h>

int numTeams(int* rating, int n) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        int left_less = 0, left_greater = 0;
        int right_less = 0, right_greater = 0;
        for (int j = 0; j < i; j++) {
            if (rating[j] < rating[i]) left_less++;
            else if (rating[j] > rating[i]) left_greater++;
        }
        for (int j = i + 1; j < n; j++) {
            if (rating[j] < rating[i]) right_less++;
            else if (rating[j] > rating[i]) right_greater++;
        }
        total += left_less * right_greater + left_greater * right_less;
    }
    return total;
}