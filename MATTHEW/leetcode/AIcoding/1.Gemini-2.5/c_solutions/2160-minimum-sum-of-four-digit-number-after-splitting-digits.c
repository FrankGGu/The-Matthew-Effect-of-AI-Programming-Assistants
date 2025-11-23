#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumSum(int num) {
    int digits[4];

    // Extract digits
    digits[0] = num % 10;
    num /= 10;
    digits[1] = num % 10;
    num /= 10;
    digits[2] = num % 10;
    num /= 10;
    digits[3] = num % 10;

    // Sort the digits in ascending order
    qsort(digits, 4, sizeof(int), compare);

    // Form two new numbers by pairing the smallest two digits for the tens places
    // and the largest two digits for the units places.
    // Example: if sorted digits are d0, d1, d2, d3
    // new1 = d0 * 10 + d2
    // new2 = d1 * 10 + d3
    int new1 = digits[0] * 10 + digits[2];
    int new2 = digits[1] * 10 + digits[3];

    return new1 + new2;
}