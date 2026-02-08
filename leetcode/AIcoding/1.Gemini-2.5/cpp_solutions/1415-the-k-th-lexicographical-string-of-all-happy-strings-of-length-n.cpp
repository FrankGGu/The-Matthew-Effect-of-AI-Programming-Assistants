#include <string>
#include <vector>

class Solution {
public:
    std::string result_str;
    int k_val;
    int count;

    void backtrack(int n, std::string& current_s) {
        if (!result_str.empty()) {
            return;
        }

        if (current_s.length() == n) {
            count++;
            if (count == k_val) {
                result_str = current_s;
            }
            return;
        }

        char last_char = current_s.empty() ? ' ' : current_s.back();

        for (char c : {'a', 'b', 'c'}) {
            if (c != last_char) {
                current_s.push_back(c);
                backtrack(n, current_s);
                current_s.pop_back();
                if (!result_str.empty()) {
                    return;
                }
            }
        }
    }

    std::string getHappyString(int n, int k) {
        result_str = "";
        k_val = k;
        count = 0;
        std::string s_builder = "";
        backtrack(n, s_builder);
        return result_str;
    }
};