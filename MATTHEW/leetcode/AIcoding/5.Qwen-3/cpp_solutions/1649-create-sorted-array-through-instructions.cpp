#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int createSortedArray(vector<int>& instructions) {
        vector<int> bit;
        int maxVal = 0;
        for (int num : instructions) {
            maxVal = max(maxVal, num);
        }
        bit.resize(maxVal + 2, 0);

        auto update = [&](int index, int val) {
            while (index < bit.size()) {
                bit[index] += val;
                index += index & -index;
            }
        };

        auto query = [&](int index) {
            int res = 0;
            while (index > 0) {
                res += bit[index];
                index -= index & -index;
            }
            return res;
        };

        int ans = 0;
        for (int num : instructions) {
            ans += min(query(num - 1), query(maxVal) - query(num));
            update(num, 1);
        }

        return ans;
    }
};