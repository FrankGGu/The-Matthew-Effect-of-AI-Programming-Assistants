#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    bool canReorderDoubled(std::vector<int>& arr) {
        std::unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        std::vector<int> keys;
        for (auto& entry : count) {
            keys.push_back(entry.first);
        }

        std::sort(keys.begin(), keys.end(), [](int a, int b) {
            return abs(a) < abs(b);
        });

        for (int num : keys) {
            if (count[num] > count[2 * num]) {
                return false;
            }
            count[2 * num] -= count[num];
        }

        return true;
    }
};