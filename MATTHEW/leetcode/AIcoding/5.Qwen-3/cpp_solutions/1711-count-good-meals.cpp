#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPairs(int target, vector<int>& nums) {
        unordered_map<int, int> freq;
        int count = 0;
        for (int num : nums) {
            count += freq[target - num];
            freq[num]++;
        }
        return count;
    }

    int countGoodMeals(vector<int>& meals) {
        int MOD = 1e9 + 7;
        int maxVal = 0;
        for (int meal : meals) {
            maxVal = max(maxVal, meal);
        }
        int maxTarget = 2 * maxVal;
        int result = 0;
        for (int target = 1; target <= maxTarget; target *= 2) {
            result = (result + countPairs(target, meals)) % MOD;
        }
        return result;
    }
};