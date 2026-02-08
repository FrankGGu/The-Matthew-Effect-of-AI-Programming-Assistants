class Node {
public:
    int val;
    Node* prev;
    Node* next;
    Node* child;

    Node() {}

    Node(int _val, Node* _prev, Node* _next, Node* _child) {
        val = _val;
        prev = _prev;
        next = _next;
        child = _child;
    }
};

class Solution {
public:
    Node* flatten(Node* head) {
        if (!head) return nullptr;
        Node* pseudoHead = new Node(0, nullptr, head, nullptr);
        Node* prev = pseudoHead;
        stack<Node*> stack;
        stack.push(head);

        while (!stack.empty()) {
            Node* curr = stack.top();
            stack.pop();
            prev->next = curr;
            curr->prev = prev;

            if (curr->next) {
                stack.push(curr->next);
            }
            if (curr->child) {
                stack.push(curr->child);
                curr->child = nullptr;
            }
            prev = curr;
        }

        pseudoHead->next->prev = nullptr;
        return pseudoHead->next;
    }
};