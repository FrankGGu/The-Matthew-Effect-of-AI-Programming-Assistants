class Solution {
public:
    Node* prev = nullptr;

    Node* treeToDoublyList(Node* root) {
        if (!root) return nullptr;
        Node* head = nullptr;
        inOrderTraversal(root, head);
        head->left = prev;
        prev->right = head;
        return head;
    }

    void inOrderTraversal(Node* node, Node*& head) {
        if (!node) return;
        inOrderTraversal(node->left, head);
        if (!head) head = node;
        node->left = prev;
        if (prev) prev->right = node;
        prev = node;
        inOrderTraversal(node->right, head);
    }
};