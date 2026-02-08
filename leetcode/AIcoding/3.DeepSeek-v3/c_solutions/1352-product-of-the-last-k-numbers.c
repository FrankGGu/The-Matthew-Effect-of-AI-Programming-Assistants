typedef struct {
    int* prefix;
    int size;
    int capacity;
} ProductOfNumbers;

ProductOfNumbers* productOfNumbersCreate() {
    ProductOfNumbers* obj = (ProductOfNumbers*)malloc(sizeof(ProductOfNumbers));
    obj->capacity = 16;
    obj->prefix = (int*)malloc(obj->capacity * sizeof(int));
    obj->prefix[0] = 1;
    obj->size = 1;
    return obj;
}

void productOfNumbersAdd(ProductOfNumbers* obj, int num) {
    if (num == 0) {
        obj->size = 1;
    } else {
        if (obj->size >= obj->capacity) {
            obj->capacity *= 2;
            obj->prefix = (int*)realloc(obj->prefix, obj->capacity * sizeof(int));
        }
        obj->prefix[obj->size] = obj->prefix[obj->size - 1] * num;
        obj->size++;
    }
}

int productOfNumbersGetProduct(ProductOfNumbers* obj, int k) {
    if (k >= obj->size) return 0;
    return obj->prefix[obj->size - 1] / obj->prefix[obj->size - k - 1];
}

void productOfNumbersFree(ProductOfNumbers* obj) {
    free(obj->prefix);
    free(obj);
}