class Solution {
public:
    bool validateBinaryTreeNodes(int n, vector<int>& leftChild, vector<int>& rightChild) {
        vector<int> inDegree(n, 0);
        for (int i = 0; i < n; ++i) {
            if (leftChild[i] != -1) {
                inDegree[leftChild[i]]++;
                if (inDegree[leftChild[i]] > 1) return false;
            }
            if (rightChild[i] != -1) {
                inDegree[rightChild[i]]++;
                if (inDegree[rightChild[i]] > 1) return false;
            }
        }
        int root = -1;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                if (root != -1) return false;
                root = i;
            }
        }
        if (root == -1) return false;
        queue<int> q;
        unordered_set<int> visited;
        q.push(root);
        visited.insert(root);
        while (!q.empty()) {
            int node = q.front();
            q.pop();
            if (leftChild[node] != -1) {
                if (visited.count(leftChild[node])) return false;
                visited.insert(leftChild[node]);
                q.push(leftChild[node]);
            }
            if (rightChild[node] != -1) {
                if (visited.count(rightChild[node])) return false;
                visited.insert(rightChild[node]);
                q.push(rightChild[node]);
            }
        }
        return visited.size() == n;
    }
};