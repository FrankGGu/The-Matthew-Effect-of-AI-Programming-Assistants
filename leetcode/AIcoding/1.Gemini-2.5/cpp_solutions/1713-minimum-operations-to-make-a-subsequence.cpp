#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& target, std::vector<int>& arr) {
        std::unordered_map<int, int> pos;
        for (int i = 0; i < target.size(); ++i) {
            pos[target[i]] = i;
        }

        std::vector<int> indices;
        for (int x : arr) {
            if (pos.count(x)) {
                indices.push_back(pos[x]);
            }
        }

        if (indices.empty()) {
            return target.size();
        }

        std::vector<int> tails;
        for (int num : indices) {
            auto it = std::lower_bound(tails.begin(), tails.end(), num);
            if (it == tails.end()) {
                tails.push_back(num);
            } else {
                *it = num;
            }
        }

        return target.size() - tails.size();
    }
};