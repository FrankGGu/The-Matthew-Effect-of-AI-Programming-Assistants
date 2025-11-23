#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestDivisible(int num) {
        if (num == 0) return "0";
        if (num == 1) return "1";

        string ans = "";
        for (int i = 9; i >= 2; --i) {
            while (num % i == 0) {
                ans += to_string(i);
                num /= i;
            }
        }

        if (num != 1) return "-1";

        reverse(ans.begin(), ans.end());
        return ans;
    }
};