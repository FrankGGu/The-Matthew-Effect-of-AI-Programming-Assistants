class Solution {
public:
    vector<int> numsSameConsecDiff(int n, int k) {
        vector<int> result;
        for (int num = 1; num <= 9; ++num) {
            dfs(num, n - 1, k, result);
        }
        return result;
    }

private:
    void dfs(int num, int remainingDigits, int k, vector<int>& result) {
        if (remainingDigits == 0) {
            result.push_back(num);
            return;
        }
        int lastDigit = num % 10;
        if (lastDigit + k <= 9) {
            dfs(num * 10 + lastDigit + k, remainingDigits - 1, k, result);
        }
        if (k != 0 && lastDigit - k >= 0) {
            dfs(num * 10 + lastDigit - k, remainingDigits - 1, k, result);
        }
    }
};