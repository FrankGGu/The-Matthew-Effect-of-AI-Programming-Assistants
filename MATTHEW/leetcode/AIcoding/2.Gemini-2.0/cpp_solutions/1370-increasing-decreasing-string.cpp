#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string sortString(string s) {
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        string result = "";
        while (result.length() < s.length()) {
            for (int i = 0; i < 26; ++i) {
                if (counts[i] > 0) {
                    result += (char)('a' + i);
                    counts[i]--;
                }
            }
            for (int i = 25; i >= 0; --i) {
                if (counts[i] > 0) {
                    result += (char)('a' + i);
                    counts[i]--;
                }
            }
        }

        return result;
    }
};