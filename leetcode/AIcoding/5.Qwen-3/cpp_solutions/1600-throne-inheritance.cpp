#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
private:
    unordered_map<string, vector<string>> graph;
    string king;

public:
    Solution(string kingName) {
        king = kingName;
    }

    void birth(string parent, string child) {
        graph[parent].push_back(child);
    }

    void death(string name) {
            }

    vector<string> getInheritanceOrder() {
        vector<string> result;
        dfs(king, result);
        return result;
    }

    void dfs(string name, vector<string>& result) {
        result.push_back(name);
        for (auto& child : graph[name]) {
            dfs(child, result);
        }
    }
};