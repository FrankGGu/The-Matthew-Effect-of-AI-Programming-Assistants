#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string extractSpell(string s) {
        string result = "";
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        int minCount = INT_MAX;
        for (int count : counts) {
            if (count > 0) {
                minCount = min(minCount, count);
            }
        }

        for (char c : s) {
            if (counts[c - 'a'] > minCount) {
                result += c;
            }
        }

        return result;
    }
};