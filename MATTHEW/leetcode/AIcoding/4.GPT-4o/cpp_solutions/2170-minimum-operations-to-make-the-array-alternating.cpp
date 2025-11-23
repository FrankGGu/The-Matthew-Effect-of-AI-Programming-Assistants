class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<pair<int, int>> freq;
        for (auto& [num, cnt] : count) {
            freq.push_back({cnt, num});
        }

        sort(freq.rbegin(), freq.rend());

        int n = nums.size();
        int totalOps = n;

        for (int i = 0; i < min(2, (int)freq.size()); i++) {
            totalOps -= freq[i].first;
        }

        if (freq.size() > 1 && freq[0].second == freq[1].second) {
            int secondMax = freq[1].first;
            totalOps = min(totalOps, n - secondMax - (freq.size() > 2 ? freq[2].first : 0));
        }

        return totalOps;
    }
};