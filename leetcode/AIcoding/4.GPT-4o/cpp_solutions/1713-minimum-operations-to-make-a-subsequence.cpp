#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& target, vector<int>& arr) {
        unordered_set<int> targetSet(target.begin(), target.end());
        vector<int> filtered;

        for (int num : arr) {
            if (targetSet.count(num)) {
                filtered.push_back(num);
            }
        }

        vector<int> dp;
        for (int num : filtered) {
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