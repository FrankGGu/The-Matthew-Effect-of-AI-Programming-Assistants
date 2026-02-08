#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    bool validateBinaryTreeNodes(int n, std::vector<int>& leftChild, std::vector<int>& rightChild) {
        std::vector<int> inDegree(n, 0);

        // Step 1: Calculate in-degrees for all nodes
        // Also, check if any node receives more than one parent link.
        for (int i = 0; i < n; ++i) {
            if (leftChild[i] != -1) {
                inDegree[leftChild[i]]++;
                if (inDegree[leftChild[i]] > 1) {
                    return false; // A node has more than one parent
                }
            }
            if (rightChild[i] != -1) {
                inDegree[rightChild[i]]++;
                if (inDegree[rightChild[i]] > 1) {
                    return false; // A node has more than one parent
                }
            }
        }

        // Step 2: Find the unique root (node with in-degree 0)
        int root = -1;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                if (root != -1) {
                    return false; // More than one root found
                }
                root = i;
            }
        }

        // If no root found, it means all nodes are part of a cycle or disconnected components without a root
        if (root == -1) {
            return false;
        }

        // Step 3: Perform BFS starting from the root to check reachability and cycles
        std::queue<int> q;
        std::vector<bool> visited(n, false);
        int visitedCount = 0;

        q.push(root);
        visited[root] = true;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            visitedCount++;

            // Visit left child
            int left = leftChild[u];
            if (left != -1) {
                if (visited[left]) {
                    return false; // Cycle detected or node revisited (should not happen in a valid tree)
                }
                visited[left] = true;
                q.push(left);
            }

            // Visit right child
            int right = rightChild[u];
            if (right != -1) {
                if (visited[right]) {
                    return false; // Cycle detected or node revisited
                }
                visited[right] = true;
                q.push(right);
            }
        }

        // Step 4: All nodes must be reachable from the root
        return visitedCount == n;
    }
};