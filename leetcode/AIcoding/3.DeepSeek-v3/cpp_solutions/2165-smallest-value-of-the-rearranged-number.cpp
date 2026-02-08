#include <algorithm>
#include <string>
#include <climits>

using namespace std;

class Solution {
public:
    long long smallestNumber(long long num) {
        if (num == 0) return 0;

        bool isNegative = num < 0;
        string s = to_string(abs(num));
        if (isNegative) {
            sort(s.rbegin(), s.rend());
            return -stoll(s);
        } else {
            sort(s.begin(), s.end());
            int firstNonZero = 0;
            while (firstNonZero < s.size() && s[firstNonZero] == '0') {
                firstNonZero++;
            }
            if (firstNonZero > 0 && firstNonZero < s.size()) {
                swap(s[0], s[firstNonZero]);
            }
            return stoll(s);
        }
    }
};