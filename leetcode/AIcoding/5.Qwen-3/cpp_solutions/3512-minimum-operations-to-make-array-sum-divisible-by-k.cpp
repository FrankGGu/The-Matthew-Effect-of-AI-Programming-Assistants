#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        unordered_map<int, int> count;
        count[0] = 1;
        int result = 0;

        for (int i = 1; i <= n; ++i) {
            int mod = prefix[i] % k;
            if (mod < 0) mod += k;
            int target = (mod - k) % k;
            result += count[target];
            count[mod]++;
        }

        return result;
    }
};