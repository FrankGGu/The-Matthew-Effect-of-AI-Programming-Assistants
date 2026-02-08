class Solution {
public:
    string removeTrailingZeros(string num) {
        int i = num.length() - 1;
        while (i >= 0 && num[i] == '0') {
            i--;
        }
        return num.substr(0, i + 1);
    }
};