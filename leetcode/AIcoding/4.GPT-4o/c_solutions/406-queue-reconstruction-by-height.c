int cmp(const void *a, const void *b) {
    int *p1 = (int *)a;
    int *p2 = (int *)b;
    if (p1[0] == p2[0]) {
        return p1[1] - p2[1];
    }
    return p2[0] - p1[0];
}

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int* returnSize) {
    qsort(people, peopleSize, sizeof(int*), cmp);
    int **result = malloc(peopleSize * sizeof(int*));
    *returnSize = peopleSize;

    for (int i = 0; i < peopleSize; i++) {
        result[i] = malloc(2 * sizeof(int));
    }

    for (int i = 0; i < peopleSize; i++) {
        int count = people[i][1];
        for (int j = 0; j < peopleSize; j++) {
            if (result[j] == NULL && count == 0) {
                result[j] = people[i];
                break;
            }
            if (result[j] != NULL && result[j][0] >= people[i][0]) {
                count--;
            }
        }
    }

    return result;
}