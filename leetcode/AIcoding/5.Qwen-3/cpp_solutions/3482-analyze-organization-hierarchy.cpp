#include <iostream>
#include <vector>
#include <map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<string>> analyzeHierarchy(vector<vector<string>>& org) {
        map<string, vector<string>> children;
        map<string, string> parent;
        vector<string> rootNodes;

        for (const auto& entry : org) {
            string employee = entry[0];
            string manager = entry[1];
            children[manager].push_back(employee);
            parent[employee] = manager;
        }

        for (const auto& entry : parent) {
            if (children.find(entry.first) == children.end()) {
                rootNodes.push_back(entry.first);
            }
        }

        vector<vector<string>> result;
        for (const auto& root : rootNodes) {
            queue<pair<string, int>> q;
            q.push({root, 0});
            vector<string> level;
            while (!q.empty()) {
                int size = q.size();
                for (int i = 0; i < size; ++i) {
                    auto [node, depth] = q.front();
                    q.pop();
                    level.push_back(node);
                    for (const auto& child : children[node]) {
                        q.push({child, depth + 1});
                    }
                }
                if (!level.empty()) {
                    result.push_back(level);
                    level.clear();
                }
            }
        }

        return result;
    }
};