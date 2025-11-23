#include <iostream>
#include <vector>
#include <memory>

using namespace std;

class Node {
public:
    int val;
    vector<shared_ptr<Node>> children;

    Node() {}

    Node(int _val) {
        val = _val;
    }

    Node(int _val, vector<shared_ptr<Node>> _children) {
        val = _val;
        children = _children;
    }
};

class Solution {
public:
    vector<int> preorder(shared_ptr<Node> root) {
        vector<int> result;
        if (!root) return result;
        vector<shared_ptr<Node>> stack;
        stack.push_back(root);
        while (!stack.empty()) {
            auto node = stack.back();
            stack.pop_back();
            result.push_back(node->val);
            for (auto it = node->children.rbegin(); it != node->children.rend(); ++it) {
                stack.push_back(*it);
            }
        }
        return result;
    }
};