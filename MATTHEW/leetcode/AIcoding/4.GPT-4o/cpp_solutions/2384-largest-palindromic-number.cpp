class Solution {
public:
    string largestPalindromic(string num) {
        vector<int> count(10, 0);
        for (char c : num) {
            count[c - '0']++;
        }

        string half = "";
        char middle = '0';

        for (int i = 9; i >= 0; --i) {
            if (count[i] > 0) {
                half += string(count[i] / 2, '0' + i);
                if (count[i] % 2 == 1 && i > middle - '0') {
                    middle = '0' + i;
                }
            }
        }

        if (half.empty() && middle == '0') return "0";

        string result = half;
        if (middle > '0') result += middle;
        reverse(half.begin(), half.end());
        result += half;

        return result[0] == '0' ? "0" : result;
    }
};