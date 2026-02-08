class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        unordered_map<int, int> count_map;
        count_map[0] = -1;
        int max_length = 0, count = 0;

        for (int i = 0; i < nums.size(); ++i) {
            count += (nums[i] == 1) ? 1 : -1;

            if (count_map.find(count) != count_map.end()) {
                max_length = max(max_length, i - count_map[count]);
            } else {
                count_map[count] = i;
            }
        }

        return max_length;
    }
};