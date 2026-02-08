/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* closestDivisors(int num, int* returnSize) {
    *returnSize = 2;
    int* res = (int*)malloc(2 * sizeof(int));

    int num1 = num + 1;
    int num2 = num + 2;

    int diff1 = num1;
    int diff2 = num2;

    int sqrt1 = (int)sqrt(num1);
    int sqrt2 = (int)sqrt(num2);

    for (int i = sqrt1; i >= 1; i--) {
        if (num1 % i == 0) {
            res[0] = i;
            res[1] = num1 / i;
            diff1 = abs(i - num1 / i);
            break;
        }
    }

    for (int i = sqrt2; i >= 1; i--) {
        if (num2 % i == 0) {
            if (abs(i - num2 / i) < diff1) {
                res[0] = i;
                res[1] = num2 / i;
            }
            break;
        }
    }

    return res;
}