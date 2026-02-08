/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are given as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    int* person1 = *(int**)a;
    int* person2 = *(int**)b;

    if (person1[0] == person2[0]) {
        return person1[1] - person2[1];
    }
    return person2[0] - person1[0];
}

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int* returnSize, int** returnColumnSizes) {
    qsort(people, peopleSize, sizeof(int*), cmp);

    int** result = (int**)malloc(peopleSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(peopleSize * sizeof(int));
    *returnSize = peopleSize;

    for (int i = 0; i < peopleSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    for (int i = 0; i < peopleSize; i++) {
        int position = people[i][1];
        for (int j = i; j > position; j--) {
            result[j] = result[j - 1];
        }
        result[position] = (int*)malloc(2 * sizeof(int));
        result[position][0] = people[i][0];
        result[position][1] = people[i][1];
    }

    return result;
}