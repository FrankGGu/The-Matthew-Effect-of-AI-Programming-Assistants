#include <iostream>
#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    bool validateBinaryTreeNodes(vector<int>& leftChild, vector<int>& rightChild) {
        int n = leftChild.size();
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
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                if (root == -1) {
                    root = i;
                } else {
                    return false;
                }
            } else if (inDegree[i] > 1) {
                return false;
            }
        }

        if (root == -1) {
            return false;
        }

        unordered_set<int> visited;
        queue<int> q;
        q.push(root);
        visited.insert(root);

        while (!q.empty()) {
            int node = q.front();
            q.pop();

            if (leftChild[node] != -1) {
                if (visited.find(leftChild[node]) != visited.end()) {
                    return false;
                }
                visited.insert(leftChild[node]);
                q.push(leftChild[node]);
            }

            if (rightChild[node] != -1) {
                if (visited.find(rightChild[node]) != visited.end()) {
                    return false;
                }
                visited.insert(rightChild[node]);
                q.push(rightChild[node]);
            }
        }

        return visited.size() == n;
    }
};