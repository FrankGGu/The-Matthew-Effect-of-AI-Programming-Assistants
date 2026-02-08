#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    vector<string> divideString(string s, int k, char fill) {
        vector<string> result;
        int n = s.length();
        for (int i = 0; i < n; i += k) {
            string sub = s.substr(i, k);
            if (sub.length() < k) {
                while (sub.length() < k) {
                    sub += fill;
                }
            }
            result.push_back(sub);
        }
        return result;
    }
};