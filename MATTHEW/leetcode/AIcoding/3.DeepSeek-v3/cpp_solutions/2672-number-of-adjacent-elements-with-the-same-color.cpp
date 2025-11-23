class Solution {
public:
    vector<int> colorTheArray(int n, vector<vector<int>>& queries) {
        vector<int> nums(n, 0);
        vector<int> res;
        int count = 0;

        for (const auto& query : queries) {
            int index = query[0];
            int color = query[1];

            if (nums[index] == color) {
                res.push_back(count);
                continue;
            }

            if (index > 0 && nums[index] != 0 && nums[index] == nums[index - 1]) {
                count--;
            }
            if (index < n - 1 && nums[index] != 0 && nums[index] == nums[index + 1]) {
                count--;
            }

            nums[index] = color;

            if (index > 0 && nums[index] == nums[index - 1]) {
                count++;
            }
            if (index < n - 1 && nums[index] == nums[index + 1]) {
                count++;
            }

            res.push_back(count);
        }

        return res;
    }
};