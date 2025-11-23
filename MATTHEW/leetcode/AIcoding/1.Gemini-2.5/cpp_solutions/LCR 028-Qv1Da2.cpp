class Node {
public:
    int val;
    Node* prev;
    Node* next;
    Node* child;
};
class Solution {
public:
    Node* flatten(Node* head) {
        Node* curr = head;
        while (curr != nullptr) {
            if (curr->child != nullptr) {
                Node* nextNode = curr->next;
                Node* childHead = curr->child;
                Node* childTail = childHead;
                while (childTail->next != nullptr) {
                    childTail = childTail->next;
                }

                curr->next = childHead;
                childHead->prev = curr;
                curr->child = nullptr;

                if (nextNode != nullptr) {
                    childTail->next = nextNode;
                    nextNode->prev = childTail;
                }
                curr = curr->next;
            } else {
                curr = curr->next;
            }
        }
        return head;
    }
};