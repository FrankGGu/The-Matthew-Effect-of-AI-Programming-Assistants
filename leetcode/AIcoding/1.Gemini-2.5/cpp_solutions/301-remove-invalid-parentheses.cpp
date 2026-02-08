#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <array>

class Solution {
public:
    std::vector<std::string> removeInvalidParentheses(std::string s) {
        std::unordered_set<std::string> resultSet;
        dfs(s, resultSet, 0, 0, {'(', ')'});
        return std::vector<std::string>(resultSet.begin(), resultSet.end());
    }

private:
    void dfs(std::string s, std::unordered_set<std::string>& result, int last_i, int last_j, const std::array<char, 2>& p) {
        int stack = 0;
        for (int i = last_i; i < s.length(); ++i) {
            if (s[i] == p[0]) stack++;
            if (s[i] == p[1]) stack--;
            if (stack >= 0) continue;

            for (int j = last_j; j <= i; ++j) {
                if (s[j] == p[1] && (j == last_j || s[j - 1] != p[1])) {
                    std::string next_s = s.substr(0, j) + s.substr(j + 1);
                    dfs(next_s, result, i, j, p);
                }
            }
            return;
        }

        std::string reversed_s = s;
        std::reverse(reversed_s.begin(), reversed_s.end());

        if (p[0] == '(') {
            dfs(reversed_s, result, 0, 0, {')', '('});
        } else {
            result.insert(reversed_s);
        }
    }
};