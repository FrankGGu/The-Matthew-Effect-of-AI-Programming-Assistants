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
            Node* curr = levelStart;
            Node* prev = NULL;

            while (curr) {
                if (curr->left) {
                    if (prev) {
                        prev->next = curr->left;
                    }
                    prev = curr->left;
                }

                if (curr->right) {
                    if (prev) {
                        prev->next = curr->right;
                    }
                    prev = curr->right;
                }

                curr = curr->next;
            }

                        while (levelStart && !levelStart->left && !levelStart->right) {
                levelStart = levelStart->next;
            }

            if (levelStart) {
                levelStart = levelStart->left ? levelStart->left : levelStart->right;
            }
        }
    }
};