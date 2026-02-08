#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int permutation(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<pair<int, int>> freq;
        for (auto const& [num, count] : counts) {
            freq.push_back({num, count});
        }

        int n = nums.size();
        long long totalPermutations = factorial(n);

        for (auto const& [num, count] : counts) {
            totalPermutations /= factorial(count);
        }

        return (int)totalPermutations;
    }

private:
    long long factorial(int n) {
        long long res = 1;
        for (int i = 2; i <= n; i++) {
            res *= i;
        }
        return res;
    }

    int permuteUniqueHelper(vector<pair<int, int>>& freq, int remaining, long long& count) {
        if (remaining == 0) {
            count++;
            return 0;
        }

        for (int i = 0; i < freq.size(); i++) {
            if (freq[i].second > 0) {
                freq[i].second--;
                permuteUniqueHelper(freq, remaining - 1, count);
                freq[i].second++;
            }
        }

        return 0;
    }

    int permuteUniqueHelperDP(vector<int>& nums, int remaining, unordered_map<string, int>& memo) {
        if (remaining == 0) {
            return 1;
        }

        string key = "";
        for (int num : nums) {
            key += to_string(num) + ",";
        }

        if (memo.count(key)) {
            return memo[key];
        }

        int count = 0;
        vector<int> nextNums = nums;
        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] > 0) {
                nextNums[i]--;
                count += permuteUniqueHelperDP(nextNums, remaining - 1, memo);
                nextNums[i]++;
            }
        }

        memo[key] = count;
        return count;
    }

public:
    int permutation_dp(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> freq;
        for (auto const& [num, count] : counts) {
            freq.push_back(count);
        }

        unordered_map<string, int> memo;
        return permuteUniqueHelperDP(freq, nums.size(), memo);
    }

    int permuteUniqueHelper(vector<int>& nums, int start, int end, long long& count) {
        if (start == end) {
            count++;
            return 0;
        }

        unordered_map<int, bool> used;
        for (int i = start; i <= end; i++) {
            if (used.find(nums[i]) == used.end()) {
                used[nums[i]] = true;
                swap(nums[start], nums[i]);
                permuteUniqueHelper(nums, start + 1, end, count);
                swap(nums[start], nums[i]);
            }
        }
        return 0;
    }

    int permutation_recursive(vector<int>& nums) {
        long long count = 0;
        permuteUniqueHelper(nums, 0, nums.size() - 1, count);
        return (int)count;
    }
};