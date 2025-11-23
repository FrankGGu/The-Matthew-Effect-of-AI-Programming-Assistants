#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countGoodSubstrings(string s) {
        int count = 0;
        for (int i = 0; i <= (int)s.length() - 3; ++i) {
            unordered_set<char> chars;
            chars.insert(s[i]);
            chars.insert(s[i + 1]);
            chars.insert(s[i + 2]);
            if (chars.size() == 3) {
                count++;
            }
        }
        return count;
    }
};