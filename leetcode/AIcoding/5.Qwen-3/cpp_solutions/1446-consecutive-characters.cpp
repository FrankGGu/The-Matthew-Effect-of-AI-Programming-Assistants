#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxPower(string s) {
        if (s.empty()) return 0;
        int maxCount = 1;
        int currentCount = 1;
        for (int i = 1; i < s.length(); ++i) {
            if (s[i] == s[i - 1]) {
                currentCount++;
                if (currentCount > maxCount) {
                    maxCount = currentCount;
                }
            } else {
                currentCount = 1;
            }
        }
        return maxCount;
    }
};