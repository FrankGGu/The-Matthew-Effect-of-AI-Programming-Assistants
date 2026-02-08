class Solution {
public:
    int countSteppingNumbers(string low, string high) {
        long long lowNum = stoll(low);
        long long highNum = stoll(high);
        vector<long long> steppingNumbers;

        function<void(long long)> dfs = [&](long long num) {
            if (num > highNum) return;
            if (num >= lowNum) steppingNumbers.push_back(num);
            int lastDigit = num % 10;
            if (lastDigit > 0) dfs(num * 10 + lastDigit - 1);
            if (lastDigit < 9) dfs(num * 10 + lastDigit + 1);
        };

        for (int i = 1; i <= 9; ++i) {
            dfs(i);
        }

        return steppingNumbers.size();
    }
};