class Solution {
public:
    int getMinDistance(vector<int>& nums, int target, int start) {
        int min_dist = INT_MAX;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == target) {
                int dist = abs(i - start);
                if (dist < min_dist) {
                    min_dist = dist;
                }
            }
        }
        return min_dist;
    }
};