#include <stdio.h>
#include <stdlib.h>

int totalFruit(int* fruits, int fruitsSize) {
    int left = 0;
    int maxFruits = 0;
    int count[2] = {0};
    int type[2] = {-1, -1};

    for (int right = 0; right < fruitsSize; right++) {
        int currentType = fruits[right];

        if (type[0] == currentType) {
            count[0]++;
        } else if (type[1] == currentType) {
            count[1]++;
        } else {
            if (type[0] == -1) {
                type[0] = currentType;
                count[0]++;
            } else if (type[1] == -1) {
                type[1] = currentType;
                count[1]++;
            } else {
                while (count[0] > 0 || count[1] > 0) {
                    int leftType = fruits[left];
                    if (leftType == type[0]) {
                        count[0]--;
                    } else {
                        count[1]--;
                    }
                    left++;
                }
                type[0] = currentType;
                count[0]++;
            }
        }

        maxFruits = (maxFruits > (count[0] + count[1])) ? maxFruits : (count[0] + count[1]);
    }

    return maxFruits;
}