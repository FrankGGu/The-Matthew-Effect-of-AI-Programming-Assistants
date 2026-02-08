class Solution {
public:
    string largestGoodInteger(string num) {
        string res = "";
        for (int i = 2; i < num.size(); ++i) {
            if (num[i] == num[i-1] && num[i] == num[i-2]) {
                string current = num.substr(i-2, 3);
                if (current > res) {
                    res = current;
                }
            }
        }
        return res;
    }
};