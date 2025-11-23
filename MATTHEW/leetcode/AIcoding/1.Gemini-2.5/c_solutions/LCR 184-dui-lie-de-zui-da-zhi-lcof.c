#include <stdlib.h>

typedef struct {
    int currentTotal;
} SelfCheckoutSystem;

SelfCheckoutSystem* selfCheckoutSystemCreate() {
    SelfCheckoutSystem* obj = (SelfCheckoutSystem*) malloc(sizeof(SelfCheckoutSystem));
    if (obj == NULL) {
        return NULL;
    }
    obj->currentTotal = 0;
    return obj;
}

void selfCheckoutSystemScanItem(SelfCheckoutSystem* obj, int price) {
    if (obj != NULL) {
        obj->currentTotal += price;
    }
}

int selfCheckoutSystemGetTotal(SelfCheckoutSystem* obj) {
    if (obj != NULL) {
        return obj->currentTotal;
    }
    return 0;
}

void selfCheckoutSystemReset(SelfCheckoutSystem* obj) {
    if (obj != NULL) {
        obj->currentTotal = 0;
    }
}

void selfCheckoutSystemFree(SelfCheckoutSystem* obj) {
    free(obj);
}