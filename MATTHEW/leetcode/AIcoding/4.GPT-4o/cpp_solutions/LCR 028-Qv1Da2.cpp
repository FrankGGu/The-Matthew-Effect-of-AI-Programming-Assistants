class Solution {
public:
    Node* flatten(Node* head) {
        if (!head) return nullptr;

        Node* dummy = new Node(0, nullptr, nullptr, nullptr);
        Node* curr = dummy;
        stack<Node*> stk;
        stk.push(head);

        while (!stk.empty()) {
            Node* node = stk.top();
            stk.pop();
            curr->next = node;
            node->prev = curr;
            curr = curr->next;

            if (node->next) {
                stk.push(node->next);
            }
            if (node->child) {
                stk.push(node->child);
                node->child = nullptr;
            }
        }

        dummy->next->prev = nullptr; // set the prev of the head to nullptr
        return dummy->next;
    }
};