#include <stdlib.h> // For malloc, free, qsort
#include <stdbool.h> // For bool

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxStrength(int* nums, int numsSize) {
    if (numsSize == 1) {
        return (long long)nums[0];
    }

    int* positives = (int*)malloc(sizeof(int) * numsSize);
    int pos_count = 0;
    int* negatives = (int*)malloc(sizeof(int) * numsSize);
    int neg_count = 0;
    int zero_count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            positives[pos_count++] = nums[i];
        } else if (nums[i] < 0) {
            negatives[neg_count++] = nums[i];
        } else {
            zero_count++;
        }
    }

    long long product = 1LL;
    bool has_any_non_zero_product_component = false;

    for (int i = 0; i < pos_count; i++) {
        product *= positives[i];
        has_any_non_zero_product_component = true;
    }

    if (neg_count > 0) {
        qsort(negatives, neg_count, sizeof(int), compare);

        if (neg_count % 2 == 0) {
            for (int i = 0; i < neg_count; i++) {
                product *= negatives[i];
            }
            has_any_non_zero_product_component = true;
        } else {
            if (pos_count > 0 || neg_count > 1) {
                for (int i = 0; i < neg_count - 1; i++) {
                    product *= negatives[i];
                }
                has_any_non_zero_product_component = true;
            }
        }
    }

    free(positives);
    free(negatives);

    if (has_any_non_zero_product_component) {
        return product;
    } else {
        return 0LL;
    }
}