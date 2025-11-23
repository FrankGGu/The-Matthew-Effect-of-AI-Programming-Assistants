#include <vector>
#include <algorithm> // Not strictly needed, but often useful for vector operations

class Node {
public:
    int val;
    std::vector<Node*> children;

    Node() {}

    Node(int _val) {
        val = _val;
    }

    Node(int _val, std::vector<Node*> _children) {
        val = _val;
        children = _children;
    }
};

class Solution {
public:
    std::vector<int> postorder(Node* root) {
        std::vector<int> result;
        traverse(root, result);
        return result;
    }

private:
    void traverse(Node* node, std::vector<int>& result) {
        if (node == nullptr) {
            return;
        }

        for (Node* child : node->children) {
            traverse(child, result);
        }

        result.push_back(node->val);
    }
};