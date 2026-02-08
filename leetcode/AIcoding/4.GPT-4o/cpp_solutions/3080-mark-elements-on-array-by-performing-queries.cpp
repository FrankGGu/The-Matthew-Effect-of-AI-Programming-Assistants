class Solution {
public:
    vector<int> arrayChange(vector<int>& nums, vector<vector<int>>& operations) {
        unordered_map<int, int> num_to_index;
        for (int i = 0; i < nums.size(); ++i) {
            num_to_index[nums[i]] = i;
        }
        for (const auto& op : operations) {
            int old_num = op[0], new_num = op[1];
            if (num_to_index.count(old_num)) {
                int index = num_to_index[old_num];
                nums[index] = new_num;
                num_to_index.erase(old_num);
                num_to_index[new_num] = index;
            }
        }
        return nums;
    }
};