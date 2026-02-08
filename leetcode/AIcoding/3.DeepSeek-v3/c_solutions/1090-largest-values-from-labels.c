typedef struct {
    int value;
    int label;
} Item;

int cmp(const void* a, const void* b) {
    return ((Item*)b)->value - ((Item*)a)->value;
}

int largestValsFromLabels(int* values, int valuesSize, int* labels, int labelsSize, int numWanted, int useLimit) {
    Item* items = (Item*)malloc(valuesSize * sizeof(Item));
    for (int i = 0; i < valuesSize; i++) {
        items[i].value = values[i];
        items[i].label = labels[i];
    }

    qsort(items, valuesSize, sizeof(Item), cmp);

    int* labelCount = (int*)calloc(20001, sizeof(int));
    int sum = 0;
    int count = 0;

    for (int i = 0; i < valuesSize && count < numWanted; i++) {
        if (labelCount[items[i].label] < useLimit) {
            sum += items[i].value;
            labelCount[items[i].label]++;
            count++;
        }
    }

    free(items);
    free(labelCount);
    return sum;
}