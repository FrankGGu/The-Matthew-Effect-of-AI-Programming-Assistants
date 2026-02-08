#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int possibleEdges(int n, vector<vector<int>>& edges) {
        unordered_map<int, unordered_set<int>> adj;
        for (const auto& e : edges) {
            adj[e[0]].insert(e[1]);
            adj[e[1]].insert(e[0]);
        }

        unordered_map<int, int> degree;
        for (const auto& e : edges) {
            degree[e[0]]++;
            degree[e[1]]++;
        }

        vector<int> degList;
        for (const auto& d : degree) {
            degList.push_back(d.second);
        }
        sort(degList.begin(), degList.end());

        if (degList[0] != 1 || degList.back() > n - 1) return 0;

        for (int i = 1; i < degList.size(); ++i) {
            if (degList[i] < degList[i - 1]) return 0;
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                ++count;
            }
        }

        if (count != 2) return 0;

        return 1;
    }
};