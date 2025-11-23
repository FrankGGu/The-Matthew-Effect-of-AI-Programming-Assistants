#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    int rearrangeCharacters(string target, string text) {
        map<char, int> countTarget;
        map<char, int> countText;

        for (char c : target) {
            countTarget[c]++;
        }

        for (char c : text) {
            countText[c]++;
        }

        int minCount = INT_MAX;

        for (auto& [c, cnt] : countTarget) {
            if (countText.find(c) == countText.end()) {
                return 0;
            }
            minCount = min(minCount, countText[c] / cnt);
        }

        return minCount;
    }
};