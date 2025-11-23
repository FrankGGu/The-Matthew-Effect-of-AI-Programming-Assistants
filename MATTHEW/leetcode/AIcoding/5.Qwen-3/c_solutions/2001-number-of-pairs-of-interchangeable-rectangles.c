#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int numerator;
    int denominator;
} Fraction;

int compare(const void *a, const void *b) {
    Fraction *f1 = (Fraction *)a;
    Fraction *f2 = (Fraction *)b;
    long long cross1 = (long long)f1->numerator * f2->denominator;
    long long cross2 = (long long)f2->numerator * f1->denominator;
    if (cross1 < cross2) return -1;
    if (cross1 > cross2) return 1;
    return 0;
}

unsigned long long countPairs(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    Fraction *fractions = (Fraction *)malloc(rectanglesSize * sizeof(Fraction));
    for (int i = 0; i < rectanglesSize; i++) {
        int w = rectangles[i][0];
        int h = rectangles[i][1];
        int gcd_val = __gcd(w, h);
        fractions[i].numerator = w / gcd_val;
        fractions[i].denominator = h / gcd_val;
    }

    qsort(fractions, rectanglesSize, sizeof(Fraction), compare);

    unsigned long long result = 0;
    int count = 1;
    for (int i = 1; i < rectanglesSize; i++) {
        if (fractions[i].numerator == fractions[i - 1].numerator && fractions[i].denominator == fractions[i - 1].denominator) {
            count++;
        } else {
            result += (unsigned long long)count * (count - 1) / 2;
            count = 1;
        }
    }
    result += (unsigned long long)count * (count - 1) / 2;

    free(fractions);
    return result;
}