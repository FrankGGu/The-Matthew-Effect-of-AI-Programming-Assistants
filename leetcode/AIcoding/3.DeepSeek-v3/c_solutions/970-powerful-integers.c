/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* powerfulIntegers(int x, int y, int bound, int* returnSize) {
    if (bound < 2) {
        *returnSize = 0;
        return NULL;
    }

    int max_i = 0, max_j = 0;

    if (x > 1) {
        int temp = 1;
        while (temp <= bound) {
            max_i++;
            temp *= x;
        }
    } else {
        max_i = 1;
    }

    if (y > 1) {
        int temp = 1;
        while (temp <= bound) {
            max_j++;
            temp *= y;
        }
    } else {
        max_j = 1;
    }

    int* result = (int*)malloc(sizeof(int) * (bound + 1));
    int count = 0;

    for (int i = 0; i < max_i; i++) {
        int pow_x = 1;
        for (int k = 0; k < i; k++) {
            pow_x *= x;
        }

        for (int j = 0; j < max_j; j++) {
            int pow_y = 1;
            for (int k = 0; k < j; k++) {
                pow_y *= y;
            }

            int sum = pow_x + pow_y;
            if (sum <= bound) {
                int found = 0;
                for (int k = 0; k < count; k++) {
                    if (result[k] == sum) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    result[count++] = sum;
                }
            } else {
                break;
            }
        }
    }

    *returnSize = count;
    return result;
}