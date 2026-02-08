class Solution {
public:
    string thousandSeparator(int n) {
        string result = to_string(n);
        int len = result.length();
        for (int i = len - 3; i > 0; i -= 3) {
            result.insert(i, ".");
        }
        return result;
    }
};