#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canReorderDoubled(vector<int>& arr) {
        unordered_map<int, int> count;
        for (int x : arr) {
            count[x]++;
        }

        vector<int> keys;
        for (auto const& [key, val] : count) {
            keys.push_back(key);
        }
        sort(keys.begin(), keys.end(), [](int a, int b) {
            return abs(a) < abs(b);
        });

        for (int x : keys) {
            if (count[x] > 0) {
                int doubled = 2 * x;
                if (count.find(doubled) == count.end() || count[doubled] < count[x]) {
                    return false;
                }
                count[doubled] -= count[x];
            }
        }

        return true;
    }
};