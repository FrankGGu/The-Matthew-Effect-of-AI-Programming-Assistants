class Solution {
public:
    int subarrayGCD(vector<int>& nums, int k) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int current_gcd = nums[i];
            for (int j = i; j < n; ++j) {
                current_gcd = gcd(current_gcd, nums[j]);
                if (current_gcd == k) {
                    res++;
                } else if (current_gcd < k) {
                    break;
                }
            }
        }
        return res;
    }

private:
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};