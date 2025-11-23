typedef struct {
    int* memory;
    int size;
} Allocator;

Allocator* allocatorCreate(int n) {
    Allocator* obj = (Allocator*)malloc(sizeof(Allocator));
    obj->memory = (int*)calloc(n, sizeof(int));
    obj->size = n;
    return obj;
}

int allocatorAllocate(Allocator* obj, int size, int mID) {
    int consecutive = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->memory[i] == 0) {
            consecutive++;
            if (consecutive == size) {
                for (int j = i - size + 1; j <= i; j++) {
                    obj->memory[j] = mID;
                }
                return i - size + 1;
            }
        } else {
            consecutive = 0;
        }
    }
    return -1;
}

int allocatorFree(Allocator* obj, int mID) {
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->memory[i] == mID) {
            obj->memory[i] = 0;
            count++;
        }
    }
    return count;
}

void allocatorFreeMem(Allocator* obj) {
    free(obj->memory);
    free(obj);
}