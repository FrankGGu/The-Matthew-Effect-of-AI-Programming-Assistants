class Solution {
public:
    bool validateBinaryTreeNodes(int n, vector<int>& leftChild, vector<int>& rightChild) {
        vector<int> indegree(n, 0);
        for (int i = 0; i < n; ++i) {
            if (leftChild[i] != -1) {
                indegree[leftChild[i]]++;
            }
            if (rightChild[i] != -1) {
                indegree[rightChild[i]]++;
            }
        }
        int rootCount = 0;
        for (int i = 0; i < n; ++i) {
            if (indegree[i] == 0) {
                rootCount++;
            } else if (indegree[i] > 1) {
                return false;
            }
        }
        return rootCount == 1;
    }
};