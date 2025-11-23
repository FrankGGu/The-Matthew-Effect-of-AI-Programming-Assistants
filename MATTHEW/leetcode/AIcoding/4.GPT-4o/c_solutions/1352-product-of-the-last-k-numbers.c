typedef struct {
    int* nums;
    int size;
    int product;
} ProductOfNumbers;

ProductOfNumbers* productOfNumbersCreate() {
    ProductOfNumbers* obj = (ProductOfNumbers*)malloc(sizeof(ProductOfNumbers));
    obj->nums = (int*)malloc(1000 * sizeof(int));
    obj->size = 0;
    obj->product = 1;
    return obj;
}

void productOfNumbersAdd(ProductOfNumbers* obj, int num) {
    if (num == 0) {
        obj->size = 0;
        obj->product = 1;
    } else {
        if (obj->size == 0) {
            obj->nums[obj->size++] = num;
            obj->product = num;
        } else {
            obj->nums[obj->size++] = num;
            obj->product *= num;
        }
    }
}

int productOfNumbersGetProduct(ProductOfNumbers* obj, int k) {
    if (k > obj->size) return 0;
    int result = 1;
    for (int i = obj->size - k; i < obj->size; i++) {
        result *= obj->nums[i];
    }
    return result;
}

void productOfNumbersFree(ProductOfNumbers* obj) {
    free(obj->nums);
    free(obj);
}