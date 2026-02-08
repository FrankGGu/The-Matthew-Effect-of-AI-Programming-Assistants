class Solution {
public:
    Node* treeToDoublyList(Node* root) {
        if (!root) return nullptr;
        Node* first = nullptr;
        Node* last = nullptr;
        inorder(root, first, last);
        first->left = last;
        last->right = first;
        return first;
    }

private:
    void inorder(Node* node, Node*& first, Node*& last) {
        if (!node) return;
        inorder(node->left, first, last);
        if (last) {
            last->right = node;
            node->left = last;
        } else {
            first = node;
        }
        last = node;
        inorder(node->right, first, last);
    }
};