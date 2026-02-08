#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int countSubstrings(string s) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int ones = 0;
                int zeros = 0;
                for (int k = i; k <= j; ++k) {
                    if (s[k] == '1') {
                        ones++;
                    } else {
                        zeros++;
                    }
                }
                if (ones > zeros) {
                    count++;
                }
            }
        }
        return count;
    }
};