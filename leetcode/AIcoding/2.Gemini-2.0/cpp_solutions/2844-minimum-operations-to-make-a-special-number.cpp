#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(string num) {
        int n = num.size();
        int countZero = 0;
        int countFive = 0;
        int ans = n;

        for (int i = n - 1; i >= 0; i--) {
            if (num[i] == '0') {
                countZero++;
                ans = min(ans, n - i - 1);
                if (countFive > 0) {
                    ans = min(ans, n - i - 2);
                }
            } else if (num[i] == '5') {
                countFive++;
                if (countZero > 0) {
                    ans = min(ans, n - i - 2);
                }
            }
        }

        if (countZero == 0) return n;
        if (ans == n && countZero == 1 && n == 1) return 1;
        if (ans == n && countZero > 0 && n == 1) return 1;

        return ans;
    }
};