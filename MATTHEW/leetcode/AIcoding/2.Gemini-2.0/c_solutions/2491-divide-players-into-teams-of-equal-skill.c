#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long dividePlayers(int* skill, int skillSize){
    qsort(skill, skillSize, sizeof(int), cmp);

    long long sum = 0;
    int target = skill[0] + skill[skillSize - 1];

    for (int i = 0; i < skillSize / 2; i++) {
        if (skill[i] + skill[skillSize - 1 - i] != target) {
            return -1;
        }
        sum += (long long)skill[i] * skill[skillSize - 1 - i];
    }

    return sum;
}