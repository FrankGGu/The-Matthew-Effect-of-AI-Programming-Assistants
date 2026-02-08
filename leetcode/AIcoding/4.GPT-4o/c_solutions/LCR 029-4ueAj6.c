struct Node {
    int val;
    struct Node *next;
};

struct Node* insert(struct Node* head, int insertVal) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->val = insertVal;

    if (!head) {
        newNode->next = newNode;
        return newNode;
    }

    struct Node *prev = head, *curr = head->next;
    while (1) {
        if (prev->val <= insertVal && insertVal <= curr->val) {
            break;
        }
        if (prev->val > curr->val) {
            if (insertVal >= prev->val || insertVal <= curr->val) {
                break;
            }
        }
        prev = curr;
        curr = curr->next;
        if (prev == head) break;
    }

    prev->next = newNode;
    newNode->next = curr;
    return head;
}