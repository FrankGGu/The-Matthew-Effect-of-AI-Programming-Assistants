#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    string smallestSubstring(string s) {
        unordered_map<char, int> count;
        int left = 0, minLen = INT_MAX, resultLeft = 0, resultRight = 0;
        int uniqueChars = 0;

        for (int right = 0; right < s.length(); ++right) {
            if (count[s[right]] == 0) {
                uniqueChars++;
            }
            count[s[right]]++;

            while (uniqueChars == 1) {
                int currentLen = right - left + 1;
                if (currentLen < minLen) {
                    minLen = currentLen;
                    resultLeft = left;
                    resultRight = right;
                }

                count[s[left]]--;
                if (count[s[left]] == 0) {
                    uniqueChars--;
                }
                left++;
            }
        }

        return s.substr(resultLeft, resultRight - resultLeft + 1);
    }
};