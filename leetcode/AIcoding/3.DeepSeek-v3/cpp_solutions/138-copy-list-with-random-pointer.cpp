class Solution {
public:
    Node* copyRandomList(Node* head) {
        if (!head) return nullptr;

        unordered_map<Node*, Node*> old_to_new;

        Node* current = head;
        while (current) {
            old_to_new[current] = new Node(current->val);
            current = current->next;
        }

        current = head;
        while (current) {
            old_to_new[current]->next = old_to_new[current->next];
            old_to_new[current]->random = old_to_new[current->random];
            current = current->next;
        }

        return old_to_new[head];
    }
};