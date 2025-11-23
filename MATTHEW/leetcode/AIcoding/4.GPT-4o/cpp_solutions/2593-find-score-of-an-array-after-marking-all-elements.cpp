class Solution {
public:
    long long findScore(vector<int>& nums) {
        int n = nums.size();
        vector<bool> marked(n, false);
        vector<pair<int, int>> indexedNums(n);

        for (int i = 0; i < n; i++) {
            indexedNums[i] = {nums[i], i};
        }

        sort(indexedNums.begin(), indexedNums.end());

        long long score = 0;

        for (const auto& [num, index] : indexedNums) {
            if (!marked[index]) {
                score += num;
                marked[index] = true;
                if (index > 0) marked[index - 1] = true;
                if (index < n - 1) marked[index + 1] = true;
            }
        }

        return score;
    }
};