#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxVowels(string s, int k) {
        int maxCount = 0, currentCount = 0;
        for (int i = 0; i < k; ++i) {
            if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                currentCount++;
            }
        }
        maxCount = currentCount;
        for (int i = k; i < s.length(); ++i) {
            if (s[i - k] == 'a' || s[i - k] == 'e' || s[i - k] == 'i' || s[i - k] == 'o' || s[i - k] == 'u') {
                currentCount--;
            }
            if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                currentCount++;
            }
            maxCount = max(maxCount, currentCount);
        }
        return maxCount;
    }
};