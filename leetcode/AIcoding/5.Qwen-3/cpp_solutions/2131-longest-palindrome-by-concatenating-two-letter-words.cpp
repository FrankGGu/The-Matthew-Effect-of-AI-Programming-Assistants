#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestPalindrome(string[] words) {
        unordered_map<string, int> count;
        for (const string& word : words) {
            count[word]++;
        }

        int result = 0;
        bool middle = false;

        for (auto& [word, freq] : count) {
            string reversed = word;
            reverse(reversed.begin(), reversed.end());
            if (word == reversed) {
                if (freq % 2 == 1) {
                    result += (freq - 1) * 2;
                    middle = true;
                } else {
                    result += freq * 2;
                }
            } else {
                int minFreq = min(count[word], count[reversed]);
                result += minFreq * 4;
                count[reversed] = 0;
            }
        }

        if (middle) {
            result += 2;
        }

        return result;
    }
};