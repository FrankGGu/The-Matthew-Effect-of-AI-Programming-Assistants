#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Node {
public:
    int val;
    Node* left;
    Node* right;
    Node* next;

    Node() : val(0), left(NULL), right(NULL), next(NULL) {}

    Node(int _val) : val(_val), left(NULL), right(NULL), next(NULL) {}

    Node(int _val, Node* _left, Node* _right, Node* _next)
        : val(_val), left(_left), right(_right), next(_next) {}
};

class Solution {
public:
    void connect(Node* root) {
        if (!root) return;

        Node* levelStart = root;

        while (levelStart) {
            Node* current = levelStart;
            while (current) {
                if (current->left) {
                    current->left->next = current->right;
                }
                if (current->right) {
                    current->right->next = current->next ? current->next->left : NULL;
                }
                current = current->next;
            }
            levelStart = levelStart->left;
        }
    }
};