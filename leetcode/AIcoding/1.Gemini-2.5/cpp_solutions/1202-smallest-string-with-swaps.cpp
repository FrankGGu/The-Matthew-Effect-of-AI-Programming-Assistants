#include <string>
#include <vector>
#include <numeric>
#include <algorithm>
#include <map>

class DSU {
public:
    std::vector<int> parent;
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
        }
    }
};

class Solution {
public:
    std::string smallestStringWithSwaps(std::string s, std::vector<std::vector<int>>& pairs) {
        int n = s.length();
        DSU dsu(n);

        for (const auto& p : pairs) {
            dsu.unite(p[0], p[1]);
        }

        std::map<int, std::vector<int>> components_indices;
        std::map<int, std::vector<char>> components_chars;

        for (int i = 0; i < n; ++i) {
            int root = dsu.find(i);
            components_indices[root].push_back(i);
            components_chars[root].push_back(s[i]);
        }

        std::string result = s;

        for (auto const& [root, indices] : components_indices) {
            std::vector<char>& chars_in_component = components_chars[root];
            std::sort(chars_in_component.begin(), chars_in_component.end());

            std::vector<int> indices_in_component = indices; 
            std::sort(indices_in_component.begin(), indices_in_component.end());

            for (int i = 0; i < indices_in_component.size(); ++i) {
                result[indices_in_component[i]] = chars_in_component[i];
            }
        }
        return result;
    }
};