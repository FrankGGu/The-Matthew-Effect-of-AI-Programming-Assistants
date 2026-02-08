class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        if (k < 0) return 0;
        unordered_map<int, int> count;
        int result = 0;

        for (int num : nums) {
            count[num]++;
        }

        for (auto& [num, cnt] : count) {
            if (k == 0) {
                if (cnt > 1) result++;
            } else {
                if (count.count(num + k)) result++;
            }
        }

        return result;
    }
};