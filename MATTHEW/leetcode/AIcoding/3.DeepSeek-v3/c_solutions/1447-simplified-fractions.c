/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** simplifiedFractions(int n, int* returnSize) {
    if (n <= 1) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 10000;
    char **result = (char **)malloc(capacity * sizeof(char *));
    int count = 0;

    for (int denominator = 2; denominator <= n; denominator++) {
        for (int numerator = 1; numerator < denominator; numerator++) {
            if (gcd(numerator, denominator) == 1) {
                char *fraction = (char *)malloc(10 * sizeof(char));
                sprintf(fraction, "%d/%d", numerator, denominator);
                result[count++] = fraction;

                if (count >= capacity) {
                    capacity *= 2;
                    result = (char **)realloc(result, capacity * sizeof(char *));
                }
            }
        }
    }

    *returnSize = count;
    return result;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}