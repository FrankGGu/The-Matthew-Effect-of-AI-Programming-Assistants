#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int scoreOfStudents(string s, vector<int>& answers) {
        int n = s.size();
        vector<int> nums;
        vector<char> ops;
        int num = 0;
        for (int i = 0; i < n; ++i) {
            if (isdigit(s[i])) {
                num = num * 10 + (s[i] - '0');
            } else {
                nums.push_back(num);
                num = 0;
                ops.push_back(s[i]);
            }
        }
        nums.push_back(num);

        int correct_answer = nums[0];
        for (int i = 0; i < ops.size(); ++i) {
            if (ops[i] == '+') {
                correct_answer += nums[i + 1];
            } else {
                correct_answer *= nums[i + 1];
            }
        }

        vector<unordered_set<int>> dp(n);
        for (int i = 0; i < nums.size(); ++i) {
            dp[i * 2].insert(nums[i]);
        }

        for (int len = 3; len <= n; len += 2) {
            for (int i = 0; i <= n - len; i += 2) {
                int j = i + len - 1;
                for (int k = i + 1; k < j; k += 2) {
                    if (s[k] == '+') {
                        for (int x : dp[i]) {
                            for (int y : dp[k + 1]) {
                                if (x + y <= 1000) {
                                    dp[i].insert(x + y);
                                }
                            }
                        }
                    } else {
                        for (int x : dp[i]) {
                            for (int y : dp[k + 1]) {
                                if (x * y <= 1000) {
                                    dp[i].insert(x * y);
                                }
                            }
                        }
                    }
                }
            }
        }

        int score = 0;
        for (int answer : answers) {
            if (answer == correct_answer) {
                score += 5;
            } else if (dp[0].count(answer)) {
                score += 2;
            }
        }

        return score;
    }
};