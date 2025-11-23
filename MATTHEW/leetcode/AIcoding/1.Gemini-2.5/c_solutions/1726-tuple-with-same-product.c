#include <stdlib.h>
#include <uthash.h>

struct ProductCount {
    int product;
    int count;
    UT_hash_handle hh;
};

int tupleSameProduct(int* nums, int numsSize) {
    struct ProductCount *products = NULL;
    struct ProductCount *entry, *tmp;
    int totalTuples = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int currentProduct = nums[i] * nums[j];

            HASH_FIND_INT(products, &currentProduct, entry);

            if (entry == NULL) {
                entry = (struct ProductCount*) malloc(sizeof(struct ProductCount));
                entry->product = currentProduct;
                entry->count = 1;
                HASH_ADD_INT(products, product, entry);
            } else {
                entry->count++;
            }
        }
    }

    HASH_ITER(hh, products, entry, tmp) {
        if (entry->count >= 2) {
            totalTuples += (entry->count * (entry->count - 1) / 2) * 8;
        }
    }

    HASH_ITER(hh, products, entry, tmp) {
        HASH_DEL(products, entry);
        free(entry);
    }

    return totalTuples;
}