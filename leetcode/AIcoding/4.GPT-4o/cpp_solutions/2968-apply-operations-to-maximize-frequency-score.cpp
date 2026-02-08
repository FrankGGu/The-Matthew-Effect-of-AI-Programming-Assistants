class Solution {
public:
    int maximizeFrequencyScore(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<pair<int, int>> freq(count.begin(), count.end());
        sort(freq.begin(), freq.end(), [](const auto& a, const auto& b) {
            return a.first < b.first;
        });

        int maxScore = 0;
        for (auto& [num, cnt] : freq) {
            maxScore += cnt;
            if (cnt > 1) {
                cnt--;
                for (int i = 1; i <= k && cnt > 0; i++) {
                    if (count.count(num + i)) {
                        cnt--;
                    }
                }
            }
        }

        return maxScore;
    }
};