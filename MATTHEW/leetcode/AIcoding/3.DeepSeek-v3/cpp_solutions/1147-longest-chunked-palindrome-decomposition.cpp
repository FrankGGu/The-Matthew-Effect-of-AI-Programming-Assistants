class Solution {
public:
    int longestDecomposition(string text) {
        int n = text.size();
        int res = 0;
        string left, right;
        for (int i = 0; i < n / 2; ++i) {
            left += text[i];
            right = text[n - 1 - i] + right;
            if (left == right) {
                res += 2;
                left = "";
                right = "";
            }
        }
        if (left != "" || n % 2 != 0) {
            res += 1;
        }
        return res;
    }
};