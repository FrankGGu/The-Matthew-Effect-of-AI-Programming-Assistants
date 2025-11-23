#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    char* path;
    struct ListNode* next;
};

struct ListNode* removeSubfolders(char** folder, int folderSize, int* returnSize) {
    qsort(folder, folderSize, sizeof(char*), (int(*)(const void*, const void*))strcmp);
    struct ListNode* head = NULL;
    struct ListNode* tail = NULL;

    for (int i = 0; i < folderSize; i++) {
        if (head == NULL || strncmp(folder[i], head->path, strlen(head->path)) != 0 || folder[i][strlen(head->path)] != '/') {
            struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
            newNode->path = folder[i];
            newNode->next = NULL;
            if (head == NULL) {
                head = newNode;
            } else {
                tail->next = newNode;
            }
            tail = newNode;
        }
    }

    int size = 0;
    struct ListNode* current = head;
    while (current) {
        size++;
        current = current->next;
    }

    *returnSize = size;
    struct ListNode* result = (struct ListNode*)malloc(size * sizeof(struct ListNode));
    current = head;
    for (int i = 0; i < size; i++) {
        result[i].path = current->path;
        current = current->next;
    }

    return result;
}