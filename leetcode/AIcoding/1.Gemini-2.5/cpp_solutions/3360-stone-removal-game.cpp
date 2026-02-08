#include <vector>
#include <unordered_map>
#include <numeric>

class Solution {
public:
    int removeStones(std::vector<std::vector<int>>& stones) {
        std::unordered_map<int, int> parent;
        int islands = 0;

        std::function<int(int)> find = [&](int i) {
            if (parent.find(i) == parent.end()) {
                parent[i] = i;
                islands++;
            }
            if (i != parent[i]) {
                parent[i] = find(parent[i]);
            }
            return parent[i];
        };

        auto unite = [&](int i, int j) {
            int root_i = find(i);
            int root_j = find(j);
            if (root_i != root_j) {
                parent[root_i] = root_j;
                islands--;
            }
        };

        for (const auto& stone : stones) {
            unite(stone[0], ~stone[1]);
        }

        return stones.size() - islands;
    }
};