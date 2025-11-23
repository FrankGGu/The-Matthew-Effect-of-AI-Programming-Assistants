class Solution {
public:
    vector<int> colorTheArray(int n, vector<vector<int>>& queries) {
        vector<int> nums(n, 0);
        vector<int> ans;
        int count = 0;
        for (auto& query : queries) {
            int index = query[0];
            int color = query[1];
            if (nums[index] != 0) {
                if (index > 0 && nums[index - 1] == nums[index]) {
                    count--;
                }
                if (index < n - 1 && nums[index + 1] == nums[index]) {
                    count--;
                }
            }
            nums[index] = color;
            if (index > 0 && nums[index - 1] == nums[index]) {
                count++;
            }
            if (index < n - 1 && nums[index + 1] == nums[index]) {
                count++;
            }
            ans.push_back(count);
        }
        return ans;
    }
};