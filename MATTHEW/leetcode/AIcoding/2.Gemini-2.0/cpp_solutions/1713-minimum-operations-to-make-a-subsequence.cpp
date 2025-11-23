#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& target, vector<int>& arr) {
        vector<int> dp;
        unordered_map<int, int> pos;
        for (int i = 0; i < target.size(); ++i) {
            pos[target[i]] = i;
        }

        vector<int> sub;
        for (int num : arr) {
            if (pos.count(num)) {
                sub.push_back(pos[num]);
            }
        }

        if (sub.empty()) {
            return target.size();
        }

        for (int num : sub) {
            auto it = lower_bound(dp.begin(), dp.end(), num);
            if (it == dp.end()) {
                dp.push_back(num);
            } else {
                *it = num;
            }
        }

        return target.size() - dp.size();
    }
};