#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> parent;

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);

        if (root_i != root_j) {
            if (root_i < root_j) {
                parent[root_j] = root_i;
            } else {
                parent[root_i] = root_j;
            }
        }
    }

    std::string smallestEquivalentString(std::string s1, std::string s2, std::string baseStr) {
        parent.resize(26);
        std::iota(parent.begin(), parent.end(), 0); // Initialize parent[i] = i

        for (size_t i = 0; i < s1.length(); ++i) {
            unite(s1[i] - 'a', s2[i] - 'a');
        }

        std::string result = "";
        for (char c : baseStr) {
            result += (char)(find(c - 'a') + 'a');
        }

        return result;
    }
};