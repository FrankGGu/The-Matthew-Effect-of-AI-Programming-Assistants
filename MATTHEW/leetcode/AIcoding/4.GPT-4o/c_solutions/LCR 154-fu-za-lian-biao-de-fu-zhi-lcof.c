struct Node {
    int val;
    struct Node *next;
    struct Node *random;
    Node(int x) : val(x), next(NULL), random(NULL) {}
};

struct Node* copyRandomList(struct Node* head) {
    if (!head) return NULL;

    struct Node* current = head;
    while (current) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = current->val;
        newNode->next = current->next;
        current->next = newNode;
        current = newNode->next;
    }

    current = head;
    while (current) {
        if (current->random) {
            current->next->random = current->random->next;
        }
        current = current->next->next;
    }

    struct Node* dummy = (struct Node*)malloc(sizeof(struct Node));
    struct Node* copy = dummy;
    current = head;
    while (current) {
        copy->next = current->next;
        copy = copy->next;
        current->next = copy->next;
        current = current->next;
    }

    return dummy->next;
}