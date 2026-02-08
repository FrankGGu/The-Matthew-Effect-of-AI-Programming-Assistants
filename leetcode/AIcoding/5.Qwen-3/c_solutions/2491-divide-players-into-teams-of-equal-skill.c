#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long dividePlayers(int* skills, int skillsSize) {
    qsort(skills, skillsSize, sizeof(int), compare);
    long long total = 0;
    for (int i = 0; i < skillsSize / 2; i++) {
        int pairSkill = skills[i] + skills[skillsSize - 1 - i];
        total += (long long)skills[i] * skills[skillsSize - 1 - i];
    }
    return total;
}