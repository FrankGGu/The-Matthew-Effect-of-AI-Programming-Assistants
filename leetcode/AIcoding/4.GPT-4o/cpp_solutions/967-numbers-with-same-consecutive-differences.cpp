class Solution {
public:
    vector<int> numsSameConsecDiff(int n, int k) {
        vector<int> result;
        if (n == 1) {
            for (int i = 0; i < 10; ++i) {
                result.push_back(i);
            }
            return result;
        }

        for (int i = 1; i < 10; ++i) {
            dfs(i, n - 1, k, result);
        }

        return result;
    }

    void dfs(int num, int n, int k, vector<int>& result) {
        if (n == 0) {
            result.push_back(num);
            return;
        }

        int lastDigit = num % 10;
        if (lastDigit + k < 10) {
            dfs(num * 10 + lastDigit + k, n - 1, k, result);
        }
        if (lastDigit - k >= 0 && k > 0) {
            dfs(num * 10 + lastDigit - k, n - 1, k, result);
        }
    }
};