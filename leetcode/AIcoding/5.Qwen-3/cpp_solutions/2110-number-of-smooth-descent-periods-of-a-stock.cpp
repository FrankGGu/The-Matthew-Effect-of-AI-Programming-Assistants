#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long getDescentPeriods(string s) {
        long long count = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            long long j = i;
            while (j + 1 < n && s[j] - s[j + 1] == 1) {
                ++j;
            }
            long long len = j - i + 1;
            count += len * (len + 1) / 2;
            i = j;
        }
        return count;
    }
};