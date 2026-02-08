#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int size;
    int capacity;
} ProductOfTheLastKNumbers;

ProductOfTheLastKNumbers* productOfTheLastKNumbersCreate() {
    ProductOfTheLastKNumbers* obj = (ProductOfTheLastKNumbers*)malloc(sizeof(ProductOfTheLastKNumbers));
    obj->nums = (int*)malloc(1 * sizeof(int));
    obj->size = 0;
    obj->capacity = 1;
    return obj;
}

void productOfTheLastKNumbersAdd(ProductOfTheLastKNumbers* obj, int num) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
    }
    obj->nums[obj->size++] = num;
}

int productOfTheLastKNumbersGetProduct(ProductOfTheLastKNumbers* obj, int k) {
    int product = 1;
    for (int i = obj->size - k; i < obj->size; i++) {
        product *= obj->nums[i];
    }
    return product;
}

void productOfTheLastKNumbersFree(ProductOfTheLastKNumbers* obj) {
    free(obj->nums);
    free(obj);
}