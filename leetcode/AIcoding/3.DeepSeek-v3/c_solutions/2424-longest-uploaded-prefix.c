typedef struct {
    int* uploaded;
    int* prefix;
    int size;
    int longest;
} LUPrefix;

LUPrefix* lUPrefixCreate(int n) {
    LUPrefix* obj = (LUPrefix*)malloc(sizeof(LUPrefix));
    obj->uploaded = (int*)calloc(n + 2, sizeof(int));
    obj->prefix = (int*)calloc(n + 2, sizeof(int));
    obj->size = n;
    obj->longest = 0;
    return obj;
}

void lUPrefixUpload(LUPrefix* obj, int video) {
    obj->uploaded[video] = 1;
    if (video == obj->longest + 1) {
        int i = video;
        while (i <= obj->size && obj->uploaded[i]) {
            i++;
        }
        obj->longest = i - 1;
    }
}

int lUPrefixLongest(LUPrefix* obj) {
    return obj->longest;
}

void lUPrefixFree(LUPrefix* obj) {
    free(obj->uploaded);
    free(obj->prefix);
    free(obj);
}