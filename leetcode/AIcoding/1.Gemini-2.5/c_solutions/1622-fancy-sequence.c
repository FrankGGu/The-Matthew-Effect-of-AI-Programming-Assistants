#include <stdlib.h>
#include <string.h> // For memcpy

#define MOD 1000000007

typedef struct {
    long long* vals;
    long long* m_at_append;
    long long* a_at_append;
    int size;
    int capacity;
    long long M_global;
    long long A_global;
} Fancy;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

Fancy* fancyCreate() {
    Fancy* obj = (Fancy*)malloc(sizeof(Fancy));
    obj->capacity = 1000;
    obj->vals = (long long*)malloc(sizeof(long long) * obj->capacity);
    obj->m_at_append = (long long*)malloc(sizeof(long long) * obj->capacity);
    obj->a_at_append = (long long*)malloc(sizeof(long long) * obj->capacity);
    obj->size = 0;
    obj->M_global = 1;
    obj->A_global = 0;
    return obj;
}

void fancyAppend(Fancy* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->vals = (long long*)realloc(obj->vals, sizeof(long long) * obj->capacity);
        obj->m_at_append = (long long*)realloc(obj->m_at_append, sizeof(long long) * obj->capacity);
        obj->a_at_append = (long long*)realloc(obj->a_at_append, sizeof(long long) * obj->capacity);
    }
    obj->vals[obj->size] = val;
    obj->m_at_append[obj->size] = obj->M_global;
    obj->a_at_append[obj->size] = obj->A_global;
    obj->size++;
}

void fancyAddAll(Fancy* obj, int inc) {
    obj->A_global = (obj->A_global + inc) % MOD;
}

void fancyMultAll(Fancy* obj, int m) {
    obj->M_global = (obj->M_global * m) % MOD;
    obj->A_global = (obj->A_global * m) % MOD;
}

int fancyGetIndex(Fancy* obj, int idx) {
    if (idx >= obj->size) {
        return -1;
    }

    long long v0 = obj->vals[idx];
    long long Mk = obj->m_at_append[idx];
    long long Ak = obj->a_at_append[idx];

    long long M_current = obj->M_global;
    long long A_current = obj->A_global;

    long long m_eff, a_eff;
    long long result;

    if (Mk == 0) {
        // If Mk was 0, it means at the time of append, the transformation was X -> Ak.
        // So, the original value v0 was appended, and then the transformation X -> Ak was applied to it.
        // This means v0 effectively became Ak.
        // Then, further operations changed the global state from (0, Ak) to (0, A_current).
        // This implies an addition of (A_current - Ak) was applied to the value Ak.
        // However, the problem example implies that if Mk was 0, the original v0 was not affected by the M_k=0.
        // Instead, it was affected by the difference in A_global.
        // So, the final value is v0 + (A_current - Ak).
        result = (v0 + (A_current - Ak));
        result = (result % MOD + MOD) % MOD; // Ensure positive result
    } else {
        // M_current = Mk * m_eff
        // A_current = Ak * m_eff + a_eff
        m_eff = (M_current * modInverse(Mk)) % MOD;
        a_eff = (A_current - (Ak * m_eff));
        a_eff = (a_eff % MOD + MOD) % MOD; // Ensure positive result

        result = (v0 * m_eff + a_eff) % MOD;
    }
    return (int)result;
}

void fancyFree(Fancy* obj) {
    free(obj->vals);
    free(obj->m_at_append);
    free(obj->a_at_append);
    free(obj);
}