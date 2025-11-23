#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool judgePoint24(int* cards, int cardsSize) {
    if (cardsSize == 1) {
        return fabs(cards[0] - 24) < 1e-6;
    }

    double nums[cardsSize];
    for (int i = 0; i < cardsSize; i++) {
        nums[i] = (double)cards[i];
    }

    double new_nums[cardsSize - 1];

    for (int i = 0; i < cardsSize; i++) {
        for (int j = i + 1; j < cardsSize; j++) {
            int k = 0;
            for (int l = 0; l < cardsSize; l++) {
                if (l != i && l != j) {
                    new_nums[k++] = nums[l];
                }
            }

            new_nums[cardsSize - 2] = nums[i] + nums[j];
            if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;

            new_nums[cardsSize - 2] = nums[i] - nums[j];
            if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;

            new_nums[cardsSize - 2] = nums[j] - nums[i];
            if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;

            new_nums[cardsSize - 2] = nums[i] * nums[j];
            if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;

            if (fabs(nums[j]) > 1e-6) {
                new_nums[cardsSize - 2] = nums[i] / nums[j];
                if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;
            }

            if (fabs(nums[i]) > 1e-6) {
                new_nums[cardsSize - 2] = nums[j] / nums[i];
                if (judgePoint24((int*)new_nums, cardsSize - 1)) return true;
            }
        }
    }

    return false;
}