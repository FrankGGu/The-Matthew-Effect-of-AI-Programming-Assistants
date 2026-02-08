struct Node {
    int val;
    Node* next;
    Node(int x) : val(x), next(nullptr) {}
};

Node* insert(Node* head, int insertVal) {
    Node* newNode = new Node(insertVal);
    if (!head) {
        newNode->next = newNode;
        return newNode;
    }
    Node* prev = head;
    Node* curr = head->next;
    bool toInsert = false;
    do {
        if ((prev->val <= insertVal && insertVal <= curr->val) || 
            (prev->val > curr->val && (insertVal >= prev->val || insertVal <= curr->val))) {
            toInsert = true;
            break;
        }
        prev = curr;
        curr = curr->next;
    } while (prev != head);

    if (toInsert) {
        prev->next = newNode;
        newNode->next = curr;
    } else {
        prev->next = newNode;
        newNode->next = curr;
    }

    return head;
}