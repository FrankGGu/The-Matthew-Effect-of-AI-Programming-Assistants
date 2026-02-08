class Solution {
public:
    int minElements(vector<int>& nums, int limit, int goal) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        long long target = goal - sum;
        if (target == 0) return 0;
        long long absTarget = abs(target);
        return (absTarget + limit - 1) / limit;
    }
};