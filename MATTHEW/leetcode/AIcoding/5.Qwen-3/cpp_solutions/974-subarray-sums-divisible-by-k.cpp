#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int subarraysDivByK(vector<int>& nums, int k) {
        vector<int> prefixMod(k, 0);
        prefixMod[0] = 1;
        int currentSum = 0;
        int count = 0;

        for (int num : nums) {
            currentSum += num;
            int mod = currentSum % k;
            if (mod < 0) mod += k;
            count += prefixMod[mod];
            prefixMod[mod]++;
        }

        return count;
    }
};