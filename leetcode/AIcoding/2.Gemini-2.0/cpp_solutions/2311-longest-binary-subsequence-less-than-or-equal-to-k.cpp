#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSubsequence(string s, int k) {
        int n = s.length();
        int count = 0;
        long long num = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == '0') {
                count++;
            } else {
                if (num + (1LL << (n - 1 - i)) <= k) {
                    num += (1LL << (n - 1 - i));
                    count++;
                }
            }
        }
        return count;
    }
};