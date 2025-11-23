#include <stdlib.h>

typedef struct {
    int value;
} NumberChain;

NumberChain* numberChainCreate(int initialValue) {
    NumberChain* chain = (NumberChain*)malloc(sizeof(NumberChain));
    if (chain == NULL) {
        return NULL;
    }
    chain->value = initialValue;
    return chain;
}

NumberChain* numberChainAdd(NumberChain* obj, int val) {
    if (obj == NULL) return NULL;
    obj->value += val;
    return obj;
}

NumberChain* numberChainSubtract(NumberChain* obj, int val) {
    if (obj == NULL) return NULL;
    obj->value -= val;
    return obj;
}

NumberChain* numberChainMultiply(NumberChain* obj, int val) {
    if (obj == NULL) return NULL;
    obj->value *= val;
    return obj;
}

int numberChainGetValue(NumberChain* obj) {
    if (obj == NULL) return 0;
    return obj->value;
}

void numberChainFree(NumberChain* obj) {
    free(obj);
}