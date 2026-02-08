#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int deliciousness(int* ingredient, int n, int limit, int idx, int sum, int* satisfaction) {
    if (idx == n) {
        if (sum >= limit) {
            int total_satisfaction = 0;
            for (int i = 0; i < n; i++) {
                if (satisfaction[i] == 1) {
                    total_satisfaction += ingredient[i];
                }
            }
            return total_satisfaction;
        } else {
            return 0;
        }
    }

    satisfaction[idx] = 0;
    int without = deliciousness(ingredient, n, limit, idx + 1, sum, satisfaction);

    satisfaction[idx] = 1;
    int with = deliciousness(ingredient, n, limit, idx + 1, sum + ingredient[idx], satisfaction);

    return (without > with) ? without : with;
}

int deliciousness_2(int* ingredient, int n, int limit) {
    int* satisfaction = (int*)malloc(sizeof(int) * n);
    int result = deliciousness(ingredient, n, limit, 0, 0, satisfaction);
    free(satisfaction);
    return result;
}