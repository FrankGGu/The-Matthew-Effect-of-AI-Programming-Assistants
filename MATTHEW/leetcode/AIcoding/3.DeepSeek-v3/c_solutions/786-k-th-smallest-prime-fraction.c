typedef struct {
    int numerator;
    int denominator;
} Fraction;

int compareFraction(const void* a, const void* b) {
    Fraction* f1 = (Fraction*)a;
    Fraction* f2 = (Fraction*)b;
    double diff = (double)f1->numerator / f1->denominator - (double)f2->numerator / f2->denominator;
    if (diff < 0) return -1;
    if (diff > 0) return 1;
    return 0;
}

int* kthSmallestPrimeFraction(int* arr, int arrSize, int k, int* returnSize) {
    Fraction* fractions = (Fraction*)malloc(arrSize * (arrSize - 1) / 2 * sizeof(Fraction));
    int idx = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            fractions[idx].numerator = arr[i];
            fractions[idx].denominator = arr[j];
            idx++;
        }
    }

    qsort(fractions, idx, sizeof(Fraction), compareFraction);

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = fractions[k - 1].numerator;
    result[1] = fractions[k - 1].denominator;
    *returnSize = 2;

    free(fractions);
    return result;
}