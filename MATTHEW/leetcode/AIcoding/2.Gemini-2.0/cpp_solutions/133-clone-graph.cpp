#include <vector>
#include <unordered_map>

using namespace std;

class Node {
public:
    int val;
    vector<Node*> neighbors;
    Node() {
        val = 0;
        neighbors = vector<Node*>();
    }
    Node(int _val) {
        val = _val;
        neighbors = vector<Node*>();
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

        unordered_map<Node*, Node*> map;
        return clone(node, map);
    }

private:
    Node* clone(Node* node, unordered_map<Node*, Node*>& map) {
        if (map.count(node)) {
            return map[node];
        }

        Node* newNode = new Node(node->val);
        map[node] = newNode;

        for (Node* neighbor : node->neighbors) {
            newNode->neighbors.push_back(clone(neighbor, map));
        }

        return newNode;
    }
};