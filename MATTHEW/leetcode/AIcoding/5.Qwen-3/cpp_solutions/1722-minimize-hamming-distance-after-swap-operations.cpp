#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minHammingDistance(vector<int>& source, vector<int>& target, vector<vector<int>>& allowedSwaps) {
        int n = source.size();
        vector<int> parent(n);

        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        function<void(int, int)> unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        for (const auto& swap : allowedSwaps) {
            unionSet(swap[0], swap[1]);
        }

        unordered_map<int, vector<int>> groups;
        for (int i = 0; i < n; ++i) {
            int root = find(i);
            groups[root].push_back(i);
        }

        int result = 0;
        for (auto& [_, indices] : groups) {
            vector<int> sourceChars;
            vector<int> targetChars;
            for (int idx : indices) {
                sourceChars.push_back(source[idx]);
                targetChars.push_back(target[idx]);
            }
            sort(sourceChars.begin(), sourceChars.end());
            sort(targetChars.begin(), targetChars.end());
            for (int i = 0; i < sourceChars.size(); ++i) {
                if (sourceChars[i] != targetChars[i]) {
                    ++result;
                }
            }
        }

        return result;
    }
};