#include <vector>

using namespace std;

class Solution {
public:
    bool validateBinaryTreeNodes(int n, vector<int>& leftChild, vector<int>& rightChild) {
        vector<int> inDegree(n, 0);
        for (int i = 0; i < n; ++i) {
            if (leftChild[i] != -1) {
                inDegree[leftChild[i]]++;
            }
            if (rightChild[i] != -1) {
                inDegree[rightChild[i]]++;
            }
        }

        int root = -1;
        int rootCount = 0;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                root = i;
                rootCount++;
            }
        }

        if (rootCount != 1) {
            return false;
        }

        vector<bool> visited(n, false);
        vector<int> q;
        q.push_back(root);
        visited[root] = true;
        int count = 0;

        while (!q.empty()) {
            int node = q[0];
            q.erase(q.begin());
            count++;

            if (leftChild[node] != -1) {
                if (visited[leftChild[node]]) {
                    return false;
                }
                visited[leftChild[node]] = true;
                q.push_back(leftChild[node]);
            }

            if (rightChild[node] != -1) {
                if (visited[rightChild[node]]) {
                    return false;
                }
                visited[rightChild[node]] = true;
                q.push_back(rightChild[node]);
            }
        }

        return count == n;
    }
};