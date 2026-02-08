class Solution {
public:
    char findKthBit(int n, int k) {
        string s = "0";
        for (int i = 2; i <= n; ++i) {
            string temp = s;
            reverse(temp.begin(), temp.end());
            for (char &c : temp) {
                c = (c == '0') ? '1' : '0';
            }
            s = s + "1" + temp;
        }
        return s[k - 1];
    }
};