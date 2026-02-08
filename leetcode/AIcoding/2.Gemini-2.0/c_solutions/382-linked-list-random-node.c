#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

typedef struct {
    struct ListNode* head;
} Solution;

Solution* solutionCreate(struct ListNode* head) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->head = head;
    return obj;
}

int solutionGetRandom(Solution* obj) {
    int result = 0;
    struct ListNode* current = obj->head;
    int count = 0;
    while (current != NULL) {
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