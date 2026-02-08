#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

typedef struct {
    ListNode *head;
} Solution;

Solution* solutionCreate(ListNode* head) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->head = head;
    return obj;
}

int solutionPickRandom(Solution* obj) {
    int result = 0;
    int count = 0;
    ListNode* current = obj->head;
    while (current) {
        count++;
        if (rand() % count == 0) {
            result = current->val;
        }
        current = current->next;
    }
    return result;
}

void solutionFree(Solution* obj) {
    free(obj);
}