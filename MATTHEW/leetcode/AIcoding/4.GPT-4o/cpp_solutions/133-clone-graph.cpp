class Node {
public:
    int val;
    vector<Node*> neighbors;
    Node() {}
    Node(int _val, vector<Node*> _neighbors) {
        val = _val;
        neighbors = _neighbors;
    }
};

class Solution {
public:
    Node* cloneGraph(Node* node) {
        if (!node) return nullptr;
        unordered_map<Node*, Node*> visited;
        return dfs(node, visited);
    }

    Node* dfs(Node* node, unordered_map<Node*, Node*>& visited) {
        if (visited.find(node) != visited.end()) {
            return visited[node];
        }
        Node* clone = new Node(node->val, {});
        visited[node] = clone;
        for (Node* neighbor : node->neighbors) {
            clone->neighbors.push_back(dfs(neighbor, visited));
        }
        return clone;
    }
};