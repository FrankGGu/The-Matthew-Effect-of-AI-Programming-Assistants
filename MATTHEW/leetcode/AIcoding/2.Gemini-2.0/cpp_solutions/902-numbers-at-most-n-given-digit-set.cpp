#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int atMostNGivenDigitSet(vector<string>& digits, int n) {
        string s = to_string(n);
        int k = s.size();
        int ans = 0;
        int m = digits.size();

        for (int i = 1; i < k; ++i) {
            ans += pow(m, i);
        }

        for (int i = 0; i < k; ++i) {
            bool hasSame = false;
            for (string& d : digits) {
                if (d[0] < s[i]) {
                    ans += pow(m, k - i - 1);
                } else if (d[0] == s[i]) {
                    hasSame = true;
                    if (i == k - 1) {
                        ans++;
                    }
                }
            }
            if (!hasSame) {
                return ans;
            }
        }

        return ans;
    }
};