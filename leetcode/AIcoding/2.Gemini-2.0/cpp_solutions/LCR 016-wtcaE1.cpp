#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int n = s.length();
        int maxLength = 0;
        unordered_map<char, int> charIndexMap;
        int start = 0;

        for (int end = 0; end < n; end++) {
            char currentChar = s[end];
            if (charIndexMap.count(currentChar) > 0 && charIndexMap[currentChar] >= start) {
                start = charIndexMap[currentChar] + 1;
            }
            charIndexMap[currentChar] = end;
            maxLength = max(maxLength, end - start + 1);
        }

        return maxLength;
    }
};