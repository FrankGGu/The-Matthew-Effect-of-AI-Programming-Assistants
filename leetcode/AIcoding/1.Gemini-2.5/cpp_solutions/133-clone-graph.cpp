class Solution {
public:
    Node* cloneGraph(Node* node) {
        if (!node) {
            return nullptr;
        }

        if (visited.count(node)) {
            return visited[node];
        }

        Node* clone_node = new Node(node->val);
        visited[node] = clone_node;

        for (Node* neighbor : node->neighbors) {
            clone_node->neighbors.push_back(cloneGraph(neighbor));
        }

        return clone_node;
    }

private:
    unordered_map<Node*, Node*> visited;
};