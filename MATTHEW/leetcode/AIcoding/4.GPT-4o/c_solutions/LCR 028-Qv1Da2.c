struct Node* flatten(struct Node* head) {
    struct Node* dummy = malloc(sizeof(struct Node));
    struct Node* prev = dummy;
    struct Node* stack[1000];
    int top = -1;

    if (head) stack[++top] = head;

    while (top != -1) {
        struct Node* curr = stack[top--];
        prev->next = curr;
        curr->prev = prev;

        if (curr->next) stack[++top] = curr->next;
        if (curr->child) {
            stack[++top] = curr->child;
            curr->child = NULL;
        }
        prev = curr;
    }
    dummy->next->prev = NULL;
    return dummy->next;
}