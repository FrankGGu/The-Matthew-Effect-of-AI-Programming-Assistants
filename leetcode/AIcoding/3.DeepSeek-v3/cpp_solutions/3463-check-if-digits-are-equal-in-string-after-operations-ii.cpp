class Solution {
public:
    bool digitCount(string num) {
        unordered_map<int, int> count;
        for (char c : num) {
            int digit = c - '0';
            count[digit]++;
        }
        for (int i = 0; i < num.size(); ++i) {
            int expected = num[i] - '0';
            if (count[i] != expected) {
                return false;
            }
        }
        return true;
    }
};