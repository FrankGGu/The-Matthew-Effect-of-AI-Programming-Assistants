#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string orderlyQueue(string s, int k) {
        if (k > 1) {
            sort(s.begin(), s.end());
            return s;
        } else {
            string ans = s;
            for (int i = 1; i < s.length(); ++i) {
                string temp = s.substr(i) + s.substr(0, i);
                if (temp < ans) {
                    ans = temp;
                }
            }
            return ans;
        }
    }
};