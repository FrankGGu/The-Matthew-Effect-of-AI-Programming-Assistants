#include <iostream>
#include <vector>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Node {
public:
    int val;
    Node *left;
    Node *right;
    Node(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    Node* treeToDoublyList(TreeNode* root) {
        if (!root) return nullptr;
        Node* dummy = new Node(0);
        Node* prev = dummy;
        inorder(root, prev);
        Node* head = dummy->right;
        head->left = prev;
        prev->right = head;
        return head;
    }

private:
    void inorder(TreeNode* node, Node*& prev) {
        if (!node) return;
        inorder(node->left, prev);
        Node* curr = new Node(node->val);
        prev->right = curr;
        curr->left = prev;
        prev = curr;
        inorder(node->right, prev);
    }
};