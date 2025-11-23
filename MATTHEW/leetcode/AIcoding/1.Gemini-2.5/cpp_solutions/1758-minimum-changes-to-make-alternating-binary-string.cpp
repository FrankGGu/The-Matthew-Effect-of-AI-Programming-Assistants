#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(string s) {
        int n = s.length();
        int count1 = 0;
        int count2 = 0;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                if (s[i] == '1') {
                    count1++;
                } else {
                    count2++;
                }
            } else {
                if (s[i] == '0') {
                    count1++;
                } else {
                    count2++;
                }
            }
        }

        return min(count1, count2);
    }
};