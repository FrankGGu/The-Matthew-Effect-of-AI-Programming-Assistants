typedef struct {
    int *nums;
    int *indices;
    int size;
} NumberContainers;

NumberContainers* numberContainersCreate() {
    NumberContainers *nc = (NumberContainers *)malloc(sizeof(NumberContainers));
    nc->nums = (int *)calloc(100001, sizeof(int));
    nc->indices = (int *)calloc(100001, sizeof(int));
    nc->size = 0;
    return nc;
}

void numberContainersChange(NumberContainers* obj, int index, int number) {
    if (obj->indices[index] > 0) {
        obj->nums[obj->indices[index]]--;
    }
    obj->indices[index] = number;
    obj->nums[number]++;
}

int numberContainersFind(NumberContainers* obj, int number) {
    for (int i = 0; i < 100001; i++) {
        if (obj->indices[i] == number) {
            return i;
        }
    }
    return -1;
}

void numberContainersFree(NumberContainers* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj);
}