class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        unordered_map<int, int> map;
        map[0] = -1;
        int max_len = 0, count = 0;
        for (int i = 0; i < nums.size(); i++) {
            count += (nums[i] == 1) ? 1 : -1;
            if (map.find(count) != map.end()) {
                max_len = max(max_len, i - map[count]);
            } else {
                map[count] = i;
            }
        }
        return max_len;
    }
};