#include <vector>

using namespace std;

class Solution {
public:
    long long minimumSteps(string s) {
        long long ans = 0;
        int white_count = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '0') {
                ans += white_count;
            } else {
                white_count++;
            }
        }
        return ans;
    }
};