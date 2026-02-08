struct Solution {
    struct ListNode *head;
};

struct Solution* solutionCreate(struct ListNode* head) {
    struct Solution* obj = (struct Solution*)malloc(sizeof(struct Solution));
    obj->head = head;
    return obj;
}

int solutionGetRandom(struct Solution* obj) {
    struct ListNode* current = obj->head;
    int result = current->val;
    int n = 1;

    while (current != NULL) {
        if (rand() % n == 0) {
            result = current->val;
        }
        n++;
        current = current->next;
    }

    return result;
}

void solutionFree(struct Solution* obj) {
    free(obj);
}