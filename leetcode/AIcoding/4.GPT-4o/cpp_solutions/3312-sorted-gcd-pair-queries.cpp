class Solution {
public:
    vector<int> gcdSort(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());

        vector<int> result;
        for (const auto& query : queries) {
            int left = query[0] - 1;
            int right = query[1] - 1;
            vector<int> temp(nums.begin() + left, nums.begin() + right + 1);
            sort(temp.begin(), temp.end());
            bool valid = true;
            for (int i = 0; i < temp.size(); ++i) {
                if (gcd(temp[i], sorted_nums[left + i]) != sorted_nums[left + i]) {
                    valid = false;
                    break;
                }
            }
            result.push_back(valid ? 1 : 0);
        }
        return result;
    }
};