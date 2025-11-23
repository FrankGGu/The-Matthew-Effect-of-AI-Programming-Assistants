class Solution {
public:
    string removeKdigits(string num, int k) {
        string result;
        for (char c : num) {
            while (!result.empty() && k > 0 && result.back() > c) {
                result.pop_back();
                k--;
            }
            if (!result.empty() || c != '0') {
                result.push_back(c);
            }
        }
        while (k > 0 && !result.empty()) {
            result.pop_back();
            k--;
        }
        return result.empty() ? "0" : result;
    }
};