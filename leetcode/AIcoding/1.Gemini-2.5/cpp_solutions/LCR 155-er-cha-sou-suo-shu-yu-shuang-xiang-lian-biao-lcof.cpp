class Solution {
public:
    Node* treeToDoublyList(Node* root) {
        if (!root) {
            return nullptr;
        }

        Node* first = nullptr;
        Node* last = nullptr;

        std::function<void(Node*)> inorder = 
            [&](Node* node) {
            if (!node) {
                return;
            }

            inorder(node->left);

            if (!first) {
                first = node;
            } else {
                last->right = node;
                node->left = last;
            }
            last = node;

            inorder(node->right);
        };

        inorder(root);

        first->left = last;
        last->right = first;

        return first;
    }
};