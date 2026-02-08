#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestSubstringBetweenTwoEqualCharacters(string s) {
        int maxLen = -1;
        vector<int> firstOccurrence(26, -1);

        for (int i = 0; i < s.length(); ++i) {
            int index = s[i] - 'a';
            if (firstOccurrence[index] == -1) {
                firstOccurrence[index] = i;
            } else {
                maxLen = max(maxLen, i - firstOccurrence[index] - 1);
            }
        }

        return maxLen;
    }
};