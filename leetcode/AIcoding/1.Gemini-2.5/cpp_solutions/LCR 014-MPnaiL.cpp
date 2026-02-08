#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    std::vector<std::string> permutation(std::string s) {
        std::vector<std::string> result;
        if (s.empty()) {
            return result;
        }

        std::string current_perm;
        std::vector<bool> used(s.length(), false);

        std::sort(s.begin(), s.end());

        backtrack(s, used, current_perm, result);

        return result;
    }

private:
    void backtrack(const std::string& s, std::vector<bool>& used, std::string& current_perm, std::vector<std::string>& result) {
        if (current_perm.length() == s.length()) {
            result.push_back(current_perm);
            return;
        }

        for (int i = 0; i < s.length(); ++i) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && s[i] == s[i-1] && !used[i-1]) {
                continue;
            }

            used[i] = true;
            current_perm.push_back(s[i]);
            backtrack(s, used, current_perm, result);
            current_perm.pop_back();
            used[i] = false;
        }
    }
};