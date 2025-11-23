#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> kthPalindrome(vector<int>& queries, int intLength) {
        vector<long long> result;
        long long start = 1;
        for (int i = 1; i < (intLength + 1) / 2; ++i) {
            start *= 10;
        }
        long long end = start * 9;

        for (int query : queries) {
            if (query > end) {
                result.push_back(-1);
            } else {
                long long num = start + query - 1;
                string s = to_string(num);
                string t = s;
                reverse(t.begin(), t.end());
                if (intLength % 2 == 0) {
                    s += t;
                } else {
                    s += t.substr(1);
                }
                result.push_back(stoll(s));
            }
        }
        return result;
    }
};