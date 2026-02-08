#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    bool equationsPossible(std::vector<std::string>& equations) {
        std::unordered_map<char, char> parent;
        for (char c = 'a'; c <= 'z'; ++c) {
            parent[c] = c;
        }

        auto find = [&](char c) {
            if (parent[c] != c) {
                parent[c] = find(parent[c]);
            }
            return parent[c];
        };

        for (const auto& eq : equations) {
            if (eq[1] == '=') {
                char a = eq[0], b = eq[3];
                parent[find(a)] = find(b);
            }
        }

        for (const auto& eq : equations) {
            if (eq[1] == '!') {
                char a = eq[0], b = eq[3];
                if (find(a) == find(b)) {
                    return false;
                }
            }
        }

        return true;
    }
};