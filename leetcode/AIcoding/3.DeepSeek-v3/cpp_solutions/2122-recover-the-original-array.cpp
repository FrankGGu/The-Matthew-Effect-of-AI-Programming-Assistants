class Solution {
public:
    vector<int> recoverArray(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        for (int i = 1; i < n; ++i) {
            int diff = nums[i] - nums[0];
            if (diff == 0 || diff % 2 != 0) continue;
            int k = diff / 2;
            if (k == 0) continue;

            unordered_map<int, int> tempFreq = freq;
            vector<int> res;
            bool valid = true;

            for (int num : nums) {
                if (tempFreq[num] == 0) continue;
                if (tempFreq[num + 2 * k] == 0) {
                    valid = false;
                    break;
                }
                tempFreq[num]--;
                tempFreq[num + 2 * k]--;
                res.push_back(num + k);
            }

            if (valid) {
                return res;
            }
        }

        return {};
    }
};