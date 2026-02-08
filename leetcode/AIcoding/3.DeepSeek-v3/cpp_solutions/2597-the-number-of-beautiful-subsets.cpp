class Solution {
public:
    int beautifulSubsets(vector<int>& nums, int k) {
        int count = 0;
        unordered_map<int, int> freq;
        backtrack(nums, k, 0, freq, count);
        return count;
    }

private:
    void backtrack(vector<int>& nums, int k, int start, unordered_map<int, int>& freq, int& count) {
        if (start == nums.size()) {
            if (!freq.empty()) {
                count++;
            }
            return;
        }

        // Option 1: Exclude nums[start]
        backtrack(nums, k, start + 1, freq, count);

        // Option 2: Include nums[start] if it's allowed
        bool canInclude = true;
        if (freq.find(nums[start] + k) != freq.end() && freq[nums[start] + k] > 0) {
            canInclude = false;
        }
        if (freq.find(nums[start] - k) != freq.end() && freq[nums[start] - k] > 0) {
            canInclude = false;
        }
        if (canInclude) {
            freq[nums[start]]++;
            backtrack(nums, k, start + 1, freq, count);
            freq[nums[start]]--;
            if (freq[nums[start]] == 0) {
                freq.erase(nums[start]);
            }
        }
    }
};