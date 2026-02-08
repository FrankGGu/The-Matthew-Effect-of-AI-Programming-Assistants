#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int nextGreaterElement(int n) {
        string s = to_string(n);
        int len = s.length();

        int i = len - 2;
        while (i >= 0 && s[i] >= s[i + 1]) {
            i--;
        }

        if (i < 0) {
            return -1;
        }

        int j = len - 1;
        while (j > i && s[j] <= s[i]) {
            j--;
        }

        swap(s[i], s[j]);
        reverse(s.begin() + i + 1, s.end());

        try {
            long long result = stoll(s);
            if (result > INT_MAX) {
                return -1;
            }
            return (int)result;
        } catch (const std::out_of_range& oor) {
            return -1;
        }
    }
};