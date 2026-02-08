#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Node {
public:
    int val;
    vector<Node*> neighbors;
    Node() {
        val = 0;
        neighbors.empty();
    }
    Node(int _val) {
        val = _val;
        neighbors.empty();
    }
    Node(int _val, vector<Node*> _neighbors) {
        val = _val;
        neighbors = _neighbors;
    }
};

class Solution {
public:
    Node* cloneGraph(Node* node) {
        if (!node) return nullptr;
        unordered_map<int, Node*> visited;
        return dfs(node, visited);
    }

private:
    Node* dfs(Node* node, unordered_map<int, Node*>& visited) {
        if (visited.find(node->val) != visited.end()) {
            return visited[node->val];
        }
        Node* clone = new Node(node->val);
        visited[node->val] = clone;
        for (Node* neighbor : node->neighbors) {
            clone->neighbors.push_back(dfs(neighbor, visited));
        }
        return clone;
    }
};