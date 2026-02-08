class Solution {
public:
    vector<vector<int>> fileCombination(int target) {
        vector<vector<int>> res;
        int left = 1, right = 2;
        int sum = left + right;
        while (left < right) {
            if (sum == target) {
                vector<int> temp;
                for (int i = left; i <= right; ++i) {
                    temp.push_back(i);
                }
                res.push_back(temp);
                sum -= left;
                left++;
            } else if (sum < target) {
                right++;
                sum += right;
            } else {
                sum -= left;
                left++;
            }
        }
        return res;
    }
};