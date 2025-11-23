using namespace std;

class Solution {
public:
    int longestSubarray(vector<int>& nums) {
        int max_val = *max_element(nums.begin(), nums.end());
        int max_length = 0;
        int current_length = 0;

        for (int num : nums) {
            if (num == max_val) {
                current_length++;
                max_length = max(max_length, current_length);
            } else {
                current_length = 0;
            }
        }

        return max_length;
    }
};