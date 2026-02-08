typedef struct {
    int id;
    int row;
    int col;
} Item;

int cmp(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;
    if (itemA->id != itemB->id) return itemB->id - itemA->id;
    if (itemA->row != itemB->row) return itemA->row - itemB->row;
    return itemA->col - itemB->col;
}

int* highestRankedKItems(int** items, int itemsSize, int* itemsColSize, int price, int k, int* returnSize) {
    Item *filtered = malloc(itemsSize * sizeof(Item));
    int count = 0;

    for (int i = 0; i < itemsSize; i++) {
        if (items[i][2] <= price) {
            filtered[count].id = items[i][0];
            filtered[count].row = items[i][1];
            filtered[count].col = items[i][2];
            count++;
        }
    }

    qsort(filtered, count, sizeof(Item), cmp);

    *returnSize = count < k ? count : k;
    int *result = malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = filtered[i].id;
    }

    free(filtered);
    return result;
}