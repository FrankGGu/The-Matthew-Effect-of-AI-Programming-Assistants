#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *prefix_product;
    int size;
    int capacity;
} ProductOfNumbers;

ProductOfNumbers* productOfNumbersCreate() {
    ProductOfNumbers *obj = (ProductOfNumbers*)malloc(sizeof(ProductOfNumbers));
    obj->capacity = 100000;
    obj->prefix_product = (int*)malloc(obj->capacity * sizeof(int));
    obj->size = 0;
    return obj;
}

void productOfNumbersAdd(ProductOfNumbers* obj, int num) {
    if (obj->size == 0) {
        if (num == 0) {
            obj->prefix_product[obj->size++] = 0;
        } else {
            obj->prefix_product[obj->size++] = num;
        }
    } else {
        if (num == 0) {
            obj->prefix_product[obj->size++] = 0;
        } else {
            obj->prefix_product[obj->size++] = obj->prefix_product[obj->size - 1] * num;
        }
    }
}

int productOfNumbersGetProduct(ProductOfNumbers* obj, int k) {
    if (k > obj->size) {
        return 0;
    }
    if (obj->prefix_product[obj->size - k] == 0) {
        for (int i = obj->size - k; i < obj->size; i++) {
            if (obj->prefix_product[i] == 0)
                return 0;
        }

        int prod = 1;
        for (int i = obj->size - k; i < obj->size; i++)
        {
            if(obj->prefix_product[i] == 0) return 0;
            if(i == 0) prod = obj->prefix_product[i];
            else prod *= obj->prefix_product[i] / (obj->prefix_product[i-1] == 0 ? 1 : obj->prefix_product[i-1]);
        }
        return prod;
    } else {
        if (obj->prefix_product[obj->size - 1] == 0)
            return 0;
        return obj->prefix_product[obj->size - 1] / obj->prefix_product[obj->size - k - 1];
    }
}

void productOfNumbersFree(ProductOfNumbers* obj) {
    free(obj->prefix_product);
    free(obj);
}