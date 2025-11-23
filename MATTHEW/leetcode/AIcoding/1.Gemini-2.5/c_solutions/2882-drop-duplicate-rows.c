#include <stdlib.h>
#include <string.h>

int compareRows(const void* a, const void* b) {
    struct Row* rowA = *(struct Row**)a;
    struct Row* rowB = *(struct Row**)b;

    if (rowA->fieldsSize != rowB->fieldsSize) {
        return rowA->fieldsSize - rowB->fieldsSize;
    }

    for (int i = 0; i < rowA->fieldsSize; i++) {
        if (rowA->fields[i] != rowB->fields[i]) {
            return rowA->fields[i] - rowB->fields[i];
        }
    }
    return 0;
}

struct Row* dropDuplicateRows(struct Row* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    int count = 0;
    struct Row* current = head;
    while (current != NULL) {
        count++;
        current = current->next;
    }

    struct Row** rowArray = (struct Row**)malloc(count * sizeof(struct Row*));
    if (rowArray == NULL) {
        return NULL; // Handle memory allocation failure
    }

    current = head;
    for (int i = 0; i < count; i++) {
        rowArray[i] = current;
        current = current->next;
    }

    qsort(rowArray, count, sizeof(struct Row*), compareRows);

    struct Row* newHead = NULL;
    struct Row* newTail = NULL;

    for (int i = 0; i < count; i++) {
        if (i == 0 || compareRows(&rowArray[i], &rowArray[i-1]) != 0) {
            if (newHead == NULL) {
                newHead = rowArray[i];
                newTail = rowArray[i];
            } else {
                newTail->next = rowArray[i];
                newTail = rowArray[i];
            }
        }
    }

    if (newTail != NULL) {
        newTail->next = NULL;
    }

    free(rowArray);

    return newHead;
}