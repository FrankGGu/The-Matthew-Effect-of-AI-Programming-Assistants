#include <string>

using namespace std;

class Solution {
public:
    string findOriginalString(string s) {
        string res = "";
        int i = 0;
        while (i < s.length()) {
            int j = i;
            while (j < s.length() && isalpha(s[j])) {
                j++;
            }
            if (j > i) {
                res += s.substr(i, j - i);
                i = j;
            } else {
                int k = i;
                while (k < s.length() && isdigit(s[k])) {
                    k++;
                }
                int num = stoi(s.substr(i, k - i));
                if (res.length() >= num) {
                    res = res.substr(0, res.length() - num);
                } else {
                    res = "";
                }
                i = k;
            }
        }
        return res;
    }
};