#include <vector>
#include <string>
#include <numeric>

class Solution {
private:
    std::vector<int> parent;
    int count;

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
            count--;
        }
    }

    bool isSimilar(const std::string& a, const std::string& b) {
        int diff = 0;
        for (size_t i = 0; i < a.length(); ++i) {
            if (a[i] != b[i]) {
                if (++diff > 2) {
                    return false;
                }
            }
        }
        return diff == 2 || diff == 0;
    }

public:
    int numSimilarGroups(std::vector<std::string>& strs) {
        int n = strs.size();
        if (n <= 1) {
            return n;
        }

        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        count = n;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isSimilar(strs[i], strs[j])) {
                    unite(i, j);
                }
            }
        }
        return count;
    }
};