#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> decorateRecord(vector<vector<int>>& root) {
        vector<vector<int>> result;
        if (root.empty()) return result;

        queue<vector<int>> q;
        q.push(root[0]);

        while (!q.empty()) {
            int size = q.size();
            vector<int> level;
            for (int i = 0; i < size; ++i) {
                vector<int> node = q.front();
                q.pop();
                level.push_back(node[0]);
                if (node.size() > 1) {
                    q.push(node[1]);
                }
                if (node.size() > 2) {
                    q.push(node[2]);
                }
            }
            result.push_back(level);
        }

        return result;
    }
};