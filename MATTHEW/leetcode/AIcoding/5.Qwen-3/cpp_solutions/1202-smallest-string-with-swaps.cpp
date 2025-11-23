#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::string smallestStringWithSwaps(std::string s, std::vector<std::vector<int>>& pairs) {
        int n = s.length();
        std::vector<int> parent(n);

        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        auto find = [&](int x) {
            while (parent[x] != x) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        };

        auto unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        for (const auto& pair : pairs) {
            unionSet(pair[0], pair[1]);
        }

        std::unordered_map<int, std::vector<int>> groups;
        for (int i = 0; i < n; ++i) {
            int root = find(i);
            groups[root].push_back(i);
        }

        for (auto& group : groups) {
            std::vector<int>& indices = group.second;
            std::vector<char> chars;
            for (int index : indices) {
                chars.push_back(s[index]);
            }
            std::sort(chars.begin(), chars.end());
            std::sort(indices.begin(), indices.end());
            for (int i = 0; i < indices.size(); ++i) {
                s[indices[i]] = chars[i];
            }
        }

        return s;
    }
};