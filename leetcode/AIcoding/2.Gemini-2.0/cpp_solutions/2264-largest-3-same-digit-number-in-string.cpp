#include <string>

using namespace std;

class Solution {
public:
    string largestGoodInteger(string num) {
        string ans = "";
        for (int i = 0; i < num.size() - 2; ++i) {
            if (num[i] == num[i + 1] && num[i + 1] == num[i + 2]) {
                string current = num.substr(i, 3);
                if (ans.empty() || current > ans) {
                    ans = current;
                }
            }
        }
        return ans;
    }
};