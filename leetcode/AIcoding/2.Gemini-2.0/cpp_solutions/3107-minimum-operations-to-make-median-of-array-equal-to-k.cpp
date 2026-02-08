#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minOperations(vector<int>& nums, int k) {
        vector<int> greater, less;
        int equal = 0;
        for (int num : nums) {
            if (num > k) {
                greater.push_back(num);
            } else if (num < k) {
                less.push_back(num);
            } else {
                equal++;
            }
        }

        int n = nums.size();
        int target = (n + 1) / 2;
        int needGreater = max(0, target - equal);

        if (needGreater > greater.size()) {
            return -1;
        }

        int needLess = needGreater + 1;
        if (needLess > less.size() + equal) return -1;

        return needGreater + needLess - equal;
    }
};