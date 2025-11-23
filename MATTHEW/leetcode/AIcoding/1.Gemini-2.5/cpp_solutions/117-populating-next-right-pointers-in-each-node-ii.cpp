class Solution {
public:
    Node* connect(Node* root) {
        Node* level_start = root;
        while (level_start) {
            Node* next_level_prev = nullptr;
            Node* next_level_head = nullptr;
            Node* curr = level_start;
            while (curr) {
                if (curr->left) {
                    if (next_level_prev) {
                        next_level_prev->next = curr->left;
                    } else {
                        next_level_head = curr->left;
                    }
                    next_level_prev = curr->left;
                }
                if (curr->right) {
                    if (next_level_prev) {
                        next_level_prev->next = curr->right;
                    } else {
                        next_level_head = curr->right;
                    }
                    next_level_prev = curr->right;
                }
                curr = curr->next;
            }
            level_start = next_level_head;
        }
        return root;
    }
};