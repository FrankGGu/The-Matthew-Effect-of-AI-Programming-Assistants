class Solution {
public:
    Node* copyRandomList(Node* head) {
        if (!head) {
            return nullptr;
        }

        Node* curr = head;
        while (curr) {
            Node* newNode = new Node(curr->val);
            newNode->next = curr->next;
            curr->next = newNode;
            curr = newNode->next;
        }

        curr = head;
        while (curr) {
            if (curr->random) {
                curr->next->random = curr->random->next;
            }
            curr = curr->next->next;
        }

        Node* original = head;
        Node* copyHead = head->next;
        Node* copy = copyHead;

        while (original) {
            original->next = original->next->next;
            if (copy->next) {
                copy->next = copy->next->next;
            } else {
                copy->next = nullptr;
            }
            original = original->next;
            copy = copy->next;
        }

        return copyHead;
    }
};