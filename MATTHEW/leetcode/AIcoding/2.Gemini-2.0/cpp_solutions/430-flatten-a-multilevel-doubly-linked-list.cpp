class Solution {
public:
    Node* flatten(Node* head) {
        Node* curr = head;
        while (curr) {
            if (curr->child) {
                Node* nextNode = curr->next;
                Node* childHead = curr->child;
                curr->next = childHead;
                childHead->prev = curr;
                curr->child = nullptr;

                Node* childTail = childHead;
                while (childTail->next) {
                    childTail = childTail->next;
                }

                if (nextNode) {
                    childTail->next = nextNode;
                    nextNode->prev = childTail;
                }
                curr = childHead;
            } else {
                curr = curr->next;
            }
        }
        return head;
    }
};