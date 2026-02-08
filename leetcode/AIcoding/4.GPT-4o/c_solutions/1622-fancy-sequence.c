typedef struct {
    long long a, b, c;
    long long mod;
} Fancy;

Fancy* fancyCreate() {
    Fancy* f = (Fancy*)malloc(sizeof(Fancy));
    f->a = 1;
    f->b = 0;
    f->c = 0;
    f->mod = 1000000007;
    return f;
}

void fancyAdd(Fancy* obj, int a) {
    obj->c = (obj->c + a) % obj->mod;
}

void fancyMulti(Fancy* obj, int b) {
    obj->a = (obj->a * b) % obj->mod;
    obj->b = (obj->b * b) % obj->mod;
    obj->c = (obj->c * b) % obj->mod;
}

int fancyGetIndex(Fancy* obj, int idx) {
    if (idx < 0) return -1;
    long long res = (obj->a * idx + obj->b) % obj->mod;
    res = (res + obj->c) % obj->mod;
    return (res < 0) ? -1 : (int)res;
}

void fancyFree(Fancy* obj) {
    free(obj);
}