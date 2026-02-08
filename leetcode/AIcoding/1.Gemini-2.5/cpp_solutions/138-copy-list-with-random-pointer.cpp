class Solution {
public:
    Node* copyRandomList(Node* head) {
        if (head == nullptr) {
            return nullptr;
        }

        Node* curr = head;
        while (curr != nullptr) {
            Node* newNode = new Node(curr->val);
            newNode->next = curr->next;
            curr->next = newNode;
            curr = newNode->next;
        }

        curr = head;
        while (curr != nullptr) {
            if (curr->random != nullptr) {
                curr->next->random = curr->random->next;
            }
            curr = curr->next->next;
        }

        Node* newHead = head->next;
        Node* originalCurr = head;
        Node* copyCurr = newHead;

        while (originalCurr != nullptr) {
            originalCurr->next = copyCurr->next;
            if (copyCurr->next != nullptr) {
                copyCurr->next = copyCurr->next->next;
            }
            originalCurr = originalCurr->next;
            copyCurr = copyCurr->next;
        }

        return newHead;
    }
};