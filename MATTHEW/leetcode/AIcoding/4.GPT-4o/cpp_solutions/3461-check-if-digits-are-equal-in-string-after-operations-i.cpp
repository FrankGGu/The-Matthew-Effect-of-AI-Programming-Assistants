class Solution {
public:
    bool areDigitsEqual(string num) {
        return all_of(num.begin() + 1, num.end(), [&](char c) { return c == num[0]; });
    }
};