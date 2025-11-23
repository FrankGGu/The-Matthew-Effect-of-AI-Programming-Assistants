class Solution {
public:
    string removeKdigits(string num, int k) {
        string result;
        for (char digit : num) {
            while (k > 0 && !result.empty() && result.back() > digit) {
                result.pop_back();
                k--;
            }
            result.push_back(digit);
        }
        result.erase(result.size() - k, k);
        while (result.size() > 1 && result.front() == '0') {
            result.erase(result.begin());
        }
        return result.empty() ? "0" : result;
    }
};