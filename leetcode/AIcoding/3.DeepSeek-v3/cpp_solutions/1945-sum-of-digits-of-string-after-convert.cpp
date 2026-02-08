class Solution {
public:
    int getLucky(string s, int k) {
        string numStr;
        for (char c : s) {
            numStr += to_string(c - 'a' + 1);
        }

        int sum = 0;
        while (k--) {
            sum = 0;
            for (char c : numStr) {
                sum += c - '0';
            }
            numStr = to_string(sum);
        }

        return sum;
    }
};