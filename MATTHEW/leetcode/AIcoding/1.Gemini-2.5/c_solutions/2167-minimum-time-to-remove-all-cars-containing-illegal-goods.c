#include <string.h>
#include <stdlib.h> // For malloc, free

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minimumTime(char * s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int *left_cost = (int *)malloc(n * sizeof(int));
    int *right_cost = (int *)malloc(n * sizeof(int));

    int prev_left_cost = 0;
    for (int i = 0; i < n; i++) {
        int current_cost_interior = prev_left_cost + (s[i] == '1' ? 2 : 0);
        int current_cost_remove_all = i + 1;
        left_cost[i] = min(current_cost_interior, current_cost_remove_all);
        prev_left_cost = left_cost[i];
    }

    int prev_right_cost = 0;
    for (int i = n - 1; i >= 0; i--) {
        int current_cost_interior = prev_right_cost + (s[i] == '1' ? 2 : 0);
        int current_cost_remove_all = n - i;
        right_cost[i] = min(current_cost_interior, current_cost_remove_all);
        prev_right_cost = right_cost[i];
    }

    int min_total_cost = n;

    min_total_cost = min(min_total_cost, right_cost[0]);

    min_total_cost = min(min_total_cost, left_cost[n-1]);

    for (int i = 0; i < n - 1; i++) {
        min_total_cost = min(min_total_cost, left_cost[i] + right_cost[i+1]);
    }

    free(left_cost);
    free(right_cost);

    return min_total_cost;
}