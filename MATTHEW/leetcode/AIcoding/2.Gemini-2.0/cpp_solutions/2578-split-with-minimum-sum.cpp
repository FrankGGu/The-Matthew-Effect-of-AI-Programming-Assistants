#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int splitNum(int num) {
        string s = to_string(num);
        sort(s.begin(), s.end());
        string num1 = "";
        string num2 = "";
        for (int i = 0; i < s.length(); ++i) {
            if (i % 2 == 0) {
                num1 += s[i];
            } else {
                num2 += s[i];
            }
        }
        return stoi(num1) + stoi(num2);
    }
};