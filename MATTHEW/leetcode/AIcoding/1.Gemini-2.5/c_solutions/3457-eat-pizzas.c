#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    if (satisfactionSize == 0) {
        return 0;
    }

    qsort(satisfaction, satisfactionSize, sizeof(int), compare);

    int max_satisfaction = 0;
    int current_sum = 0;
    int current_total_satisfaction = 0;

    for (int i = satisfactionSize - 1; i >= 0; --i) {
        if (current_sum + satisfaction[i] > 0) {
            current_sum += satisfaction[i];
            current_total_satisfaction += current_sum;
            max_satisfaction = max(max_satisfaction, current_total_satisfaction);
        } else {
            break;
        }
    }

    return max_satisfaction;
}