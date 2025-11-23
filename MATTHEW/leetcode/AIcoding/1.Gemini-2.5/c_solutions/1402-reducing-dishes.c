#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), compare);

    int max_liketime = 0;
    int current_liketime = 0;
    int current_satisfaction_sum = 0;

    for (int i = satisfactionSize - 1; i >= 0; i--) {
        int potential_new_satisfaction_sum = current_satisfaction_sum + satisfaction[i];

        // If adding the current dish (satisfaction[i]) makes the sum of
        // all chosen dishes negative, then adding it to current_liketime
        // will decrease the total liketime. Since we are iterating from
        // largest satisfaction values to smallest, any further dishes to
        // the left will be even smaller/more negative, making the sum
        // even more negative. Thus, it's optimal to stop.
        if (potential_new_satisfaction_sum < 0) {
            break;
        }

        current_satisfaction_sum = potential_new_satisfaction_sum;
        current_liketime += current_satisfaction_sum;

        if (current_liketime > max_liketime) {
            max_liketime = current_liketime;
        }
    }

    return max_liketime;
}