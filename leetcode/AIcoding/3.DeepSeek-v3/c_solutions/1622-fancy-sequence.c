typedef struct {
    long long *arr;
    int size;
    int capacity;
    long long add;
    long long mul;
} Fancy;

#define MOD 1000000007

long long modPow(long long base, long long exp) {
    long long result = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp & 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exp >>= 1;
    }
    return result;
}

Fancy* fancyCreate() {
    Fancy *obj = (Fancy*)malloc(sizeof(Fancy));
    obj->capacity = 16;
    obj->arr = (long long*)malloc(obj->capacity * sizeof(long long));
    obj->size = 0;
    obj->add = 0;
    obj->mul = 1;
    return obj;
}

void fancyAppend(Fancy* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->arr = (long long*)realloc(obj->arr, obj->capacity * sizeof(long long));
    }
    long long v = val;
    v = (v - obj->add + MOD) % MOD;
    v = (v * modPow(obj->mul, MOD - 2)) % MOD;
    obj->arr[obj->size++] = v;
}

void fancyAddAll(Fancy* obj, int inc) {
    obj->add = (obj->add + inc) % MOD;
}

void fancyMultAll(Fancy* obj, int m) {
    obj->mul = (obj->mul * m) % MOD;
    obj->add = (obj->add * m) % MOD;
}

int fancyGetIndex(Fancy* obj, int idx) {
    if (idx >= obj->size) {
        return -1;
    }
    long long val = obj->arr[idx];
    val = (val * obj->mul) % MOD;
    val = (val + obj->add) % MOD;
    return val;
}

void fancyFree(Fancy* obj) {
    free(obj->arr);
    free(obj);
}