#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxLengthBetweenEqualCharacters(string s) {
        unordered_map<char, int> firstOccurrence;
        int maxLength = -1;
        for (int i = 0; i < s.length(); ++i) {
            if (firstOccurrence.find(s[i]) == firstOccurrence.end()) {
                firstOccurrence[s[i]] = i;
            } else {
                maxLength = max(maxLength, i - firstOccurrence[s[i]] - 1);
            }
        }
        return maxLength;
    }
};