#include <vector>
#include <string>
#include <numeric>

class Solution {
private:
    std::vector<int> parent;

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
        }
    }

public:
    bool equationsPossible(std::vector<std::string>& equations) {
        parent.resize(26);
        std::iota(parent.begin(), parent.end(), 0);

        for (const std::string& eq : equations) {
            if (eq[1] == '=') {
                int var1 = eq[0] - 'a';
                int var2 = eq[3] - 'a';
                unite(var1, var2);
            }
        }

        for (const std::string& eq : equations) {
            if (eq[1] == '!') {
                int var1 = eq[0] - 'a';
                int var2 = eq[3] - 'a';
                if (find(var1) == find(var2)) {
                    return false;
                }
            }
        }

        return true;
    }
};