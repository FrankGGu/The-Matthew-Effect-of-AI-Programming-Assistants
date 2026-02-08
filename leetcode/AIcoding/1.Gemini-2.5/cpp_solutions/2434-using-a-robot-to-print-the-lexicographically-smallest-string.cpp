#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string robotWithString(std::string s) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        std::vector<char> min_char_suffix(n + 1);
        min_char_suffix[n] = 'z' + 1; 

        for (int i = n - 1; i >= 0; --i) {
            min_char_suffix[i] = std::min(s[i], min_char_suffix[i + 1]);
        }

        std::string ans = "";
        std::string t = ""; 

        for (int i = 0; i < n; ++i) {
            t.push_back(s[i]);

            while (!t.empty() && t.back() <= min_char_suffix[i + 1]) {
                ans.push_back(t.back());
                t.pop_back();
            }
        }

        while (!t.empty()) {
            ans.push_back(t.back());
            t.pop_back();
        }

        return ans;
    }
};