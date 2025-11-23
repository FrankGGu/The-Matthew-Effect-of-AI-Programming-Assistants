class Solution {
public:
    int maximumSize(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int size = 0;
        for (int num : nums) {
            if (size + num + 1 <= nums.size()) {
                size++;
            } else {
                break;
            }
        }
        return size;
    }
};