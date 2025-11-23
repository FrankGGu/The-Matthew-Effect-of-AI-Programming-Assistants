#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string customSortString(string order, string s) {
        string result = "";
        int count[26] = {0};

        for (char c : s) {
            count[c - 'a']++;
        }

        for (char c : order) {
            while (count[c - 'a'] > 0) {
                result += c;
                count[c - 'a']--;
            }
        }

        for (int i = 0; i < 26; ++i) {
            while (count[i] > 0) {
                result += (char)('a' + i);
                count[i]--;
            }
        }

        return result;
    }
};