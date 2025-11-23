class Solution {
public:
    int minimumDeletions(vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) return n;

        int min_pos = min_element(nums.begin(), nums.end()) - nums.begin();
        int max_pos = max_element(nums.begin(), nums.end()) - nums.begin();

        int left = min(min_pos, max_pos);
        int right = max(min_pos, max_pos);

        int option1 = right + 1;
        int option2 = n - left;
        int option3 = (left + 1) + (n - right);

        return min({option1, option2, option3});
    }
};