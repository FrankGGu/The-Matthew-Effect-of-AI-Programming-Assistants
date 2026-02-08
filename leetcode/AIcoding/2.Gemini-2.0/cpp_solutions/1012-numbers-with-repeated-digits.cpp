#include <vector>

using namespace std;

class Solution {
public:
    int numDupDigitsAtMostN(int n) {
        vector<int> digits;
        int temp = n + 1;
        while (temp > 0) {
            digits.push_back(temp % 10);
            temp /= 10;
        }
        reverse(digits.begin(), digits.end());

        int k = digits.size();
        int ans = 0;

        for (int i = 1; i < k; i++) {
            ans += 9 * A(9, i - 1);
        }

        vector<bool> seen(10, false);
        for (int i = 0; i < k; i++) {
            for (int j = (i == 0 ? 1 : 0); j < digits[i]; j++) {
                if (!seen[j]) {
                    ans += A(9 - i, k - i - 1);
                }
            }
            if (seen[digits[i]]) {
                break;
            }
            seen[digits[i]] = true;
            if (i == k - 1) {
                ans++;
            }
        }

        return n - ans;
    }

private:
    int A(int m, int n) {
        int ans = 1;
        for (int i = 0; i < n; i++) {
            ans *= (m - i);
        }
        return ans;
    }
};