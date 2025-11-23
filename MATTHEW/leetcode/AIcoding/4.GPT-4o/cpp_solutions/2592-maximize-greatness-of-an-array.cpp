class Solution {
public:
    int maximizeGreatness(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int greatness = 0;
        for (int num : nums) {
            if (num > greatness) {
                greatness++;
            }
        }
        return greatness;
    }
};