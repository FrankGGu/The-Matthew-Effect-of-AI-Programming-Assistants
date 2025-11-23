/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* fraction(int* cont, int contSize, int* returnSize) {
    int* res = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    long long numerator = 1;
    long long denominator = cont[contSize - 1];

    for (int i = contSize - 2; i >= 0; i--) {
        numerator += denominator * cont[i];
        long long temp = numerator;
        numerator = denominator;
        denominator = temp;
    }

    // Swap back as the last step reverses numerator and denominator
    long long temp = numerator;
    numerator = denominator;
    denominator = temp;

    // Simplify the fraction
    long long a = numerator, b = denominator;
    while (b != 0) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    long long gcd = a;

    res[0] = numerator / gcd;
    res[1] = denominator / gcd;

    return res;
}