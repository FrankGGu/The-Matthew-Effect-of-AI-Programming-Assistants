class Solution {
public:
    int minOperations(vector<int>& nums, vector<int>& numsDivide) {
        int g = numsDivide[0];
        for (int num : numsDivide) {
            g = gcd(g, num);
        }
        sort(nums.begin(), nums.end());
        for (int i = 0; i < nums.size(); ++i) {
            if (g % nums[i] == 0) {
                return i;
            }
        }
        return -1;
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