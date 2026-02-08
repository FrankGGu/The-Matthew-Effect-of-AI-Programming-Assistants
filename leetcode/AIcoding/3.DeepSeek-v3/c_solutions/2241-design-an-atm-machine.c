typedef struct {
    long long* banknotes;
} ATM;

ATM* atmCreate() {
    ATM* obj = (ATM*)malloc(sizeof(ATM));
    obj->banknotes = (long long*)calloc(5, sizeof(long long));
    return obj;
}

void atmDeposit(ATM* obj, int* banknotesCount, int banknotesCountSize) {
    for (int i = 0; i < 5; i++) {
        obj->banknotes[i] += banknotesCount[i];
    }
}

int* atmWithdraw(ATM* obj, int amount, int* returnSize) {
    int* result = (int*)calloc(5, sizeof(int));
    *returnSize = 5;

    int denominations[] = {20, 50, 100, 200, 500};

    for (int i = 4; i >= 0; i--) {
        if (amount >= denominations[i]) {
            long long needed = amount / denominations[i];
            long long available = obj->banknotes[i];
            long long take = (needed < available) ? needed : available;
            result[i] = take;
            amount -= take * denominations[i];
        }
    }

    if (amount != 0) {
        free(result);
        result = (int*)malloc(sizeof(int));
        result[0] = -1;
        *returnSize = 1;
        return result;
    }

    for (int i = 0; i < 5; i++) {
        obj->banknotes[i] -= result[i];
    }

    return result;
}

void atmFree(ATM* obj) {
    free(obj->banknotes);
    free(obj);
}