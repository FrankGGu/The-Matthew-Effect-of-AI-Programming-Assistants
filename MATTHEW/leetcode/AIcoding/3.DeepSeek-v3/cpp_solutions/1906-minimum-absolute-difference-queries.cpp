class Solution {
public:
    vector<int> minDifference(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<vector<int>> prefix(101, vector<int>(n + 1, 0));

        for (int num = 1; num <= 100; ++num) {
            for (int i = 0; i < n; ++i) {
                prefix[num][i + 1] = prefix[num][i] + (nums[i] == num ? 1 : 0);
            }
        }

        vector<int> result;
        for (auto& query : queries) {
            int left = query[0], right = query[1];
            vector<int> present;
            for (int num = 1; num <= 100; ++num) {
                if (prefix[num][right + 1] - prefix[num][left] > 0) {
                    present.push_back(num);
                }
            }

            int min_diff = INT_MAX;
            for (int i = 1; i < present.size(); ++i) {
                min_diff = min(min_diff, present[i] - present[i - 1]);
            }

            if (min_diff == INT_MAX) {
                result.push_back(-1);
            } else {
                result.push_back(min_diff);
            }
        }

        return result;
    }
};