#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int scoreOfStudents(string s, vector<int>& answers) {
        int n = s.length();
        vector<int> nums;
        vector<char> ops;
        for (int i = 0; i < n; ++i) {
            if (isdigit(s[i])) {
                int num = 0;
                while (i < n && isdigit(s[i])) {
                    num = num * 10 + (s[i] - '0');
                    ++i;
                }
                --i;
                nums.push_back(num);
            } else {
                ops.push_back(s[i]);
            }
        }

        auto calculate = [&](int a, int b, char op) {
            if (op == '+') return a + b;
            return a * b;
        };

        function<int()> evaluate = [&]() {
            vector<int> nums_copy = nums;
            vector<char> ops_copy = ops;
            vector<int> new_nums;
            vector<char> new_ops;
            new_nums.push_back(nums_copy[0]);
            for (int i = 0; i < ops_copy.size(); ++i) {
                if (ops_copy[i] == '*') {
                    new_nums.back() *= nums_copy[i + 1];
                } else {
                    new_nums.push_back(nums_copy[i + 1]);
                    new_ops.push_back(ops_copy[i]);
                }
            }

            int res = new_nums[0];
            for (int i = 0; i < new_ops.size(); ++i) {
                res += new_nums[i + 1];
            }
            return res;
        };

        int correct_answer = evaluate();

        vector<vector<unordered_set<int>>> dp(nums.size(), vector<unordered_set<int>>(nums.size()));

        for (int i = 0; i < nums.size(); ++i) {
            dp[i][i].insert(nums[i]);
        }

        for (int len = 2; len <= nums.size(); ++len) {
            for (int i = 0; i <= nums.size() - len; ++i) {
                int j = i + len - 1;
                for (int k = i; k < j; ++k) {
                    for (int a : dp[i][k]) {
                        for (int b : dp[k + 1][j]) {
                            int val = calculate(a, b, ops[k]);
                            if (val >= 0 && val <= 1000) {
                                dp[i][j].insert(val);
                            }
                        }
                    }
                }
            }
        }

        int score = 0;
        unordered_set<int> possible_answers = dp[0][nums.size() - 1];

        for (int answer : answers) {
            if (answer == correct_answer) {
                score += 5;
            } else if (possible_answers.count(answer)) {
                score += 2;
            }
        }

        return score;
    }
};