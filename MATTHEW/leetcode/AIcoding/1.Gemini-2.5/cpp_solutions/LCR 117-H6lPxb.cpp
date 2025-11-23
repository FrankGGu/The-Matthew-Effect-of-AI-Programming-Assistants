#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<int> parent;
    int numGroups;

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
            numGroups--;
        }
    }

    bool isSimilar(const std::string& s1, const std::string& s2) {
        int diffCount = 0;
        std::vector<int> diffIndices;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] != s2[i]) {
                diffCount++;
                diffIndices.push_back(i);
            }
        }

        if (diffCount == 0) {
            return true;
        }
        if (diffCount == 2) {
            return s1[diffIndices[0]] == s2[diffIndices[1]] &&
                   s1[diffIndices[1]] == s2[diffIndices[0]];
        }
        return false;
    }

    int numSimilarGroups(std::vector<std::string>& strs) {
        int n = strs.size();
        if (n == 0) return 0;

        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        numGroups = n;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isSimilar(strs[i], strs[j])) {
                    unite(i, j);
                }
            }
        }

        return numGroups;
    }
};