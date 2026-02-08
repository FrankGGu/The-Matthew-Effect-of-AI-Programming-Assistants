class Solution {
public:
    string getPermutation(int n, int k) {
        vector<int> nums;
        int fact = 1;
        for (int i = 1; i <= n; ++i) {
            nums.push_back(i);
            fact *= i;
        }

        string res;
        k--;
        for (int i = 0; i < n; ++i) {
            fact /= (n - i);
            int index = k / fact;
            res += to_string(nums[index]);
            nums.erase(nums.begin() + index);
            k %= fact;
        }
        return res;
    }
};