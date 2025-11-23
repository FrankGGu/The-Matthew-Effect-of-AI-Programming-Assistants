class Solution {
public:
    int scoreOfStudents(string s, vector<int>& answers) {
        int n = s.size();
        int correct = computeCorrect(s);
        int m = (n + 1) / 2;
        vector<vector<unordered_set<int>>> dp(m, vector<unordered_set<int>>(m));

        for (int i = 0; i < m; ++i) {
            dp[i][i].insert(s[2 * i] - '0');
        }

        for (int len = 2; len <= m; ++len) {
            for (int i = 0; i <= m - len; ++i) {
                int j = i + len - 1;
                for (int k = i; k < j; ++k) {
                    for (int a : dp[i][k]) {
                        for (int b : dp[k + 1][j]) {
                            char op = s[2 * k + 1];
                            int res;
                            if (op == '+') {
                                res = a + b;
                            } else {
                                res = a * b;
                            }
                            if (res <= 1000) {
                                dp[i][j].insert(res);
                            }
                        }
                    }
                }
            }
        }

        unordered_set<int> possible = dp[0][m - 1];
        int score = 0;
        for (int ans : answers) {
            if (ans == correct) {
                score += 5;
            } else if (possible.count(ans)) {
                score += 2;
            }
        }
        return score;
    }

private:
    int computeCorrect(string s) {
        vector<int> nums;
        vector<char> ops;
        int num = 0;
        for (char c : s) {
            if (isdigit(c)) {
                num = num * 10 + (c - '0');
            } else {
                nums.push_back(num);
                num = 0;
                ops.push_back(c);
            }
        }
        nums.push_back(num);

        vector<int> tempNums;
        vector<char> tempOps;
        tempNums.push_back(nums[0]);
        for (int i = 0; i < ops.size(); ++i) {
            if (ops[i] == '*') {
                int top = tempNums.back();
                tempNums.pop_back();
                tempNums.push_back(top * nums[i + 1]);
            } else {
                tempNums.push_back(nums[i + 1]);
                tempOps.push_back(ops[i]);
            }
        }

        int res = tempNums[0];
        for (int i = 0; i < tempOps.size(); ++i) {
            res += tempNums[i + 1];
        }
        return res;
    }
};