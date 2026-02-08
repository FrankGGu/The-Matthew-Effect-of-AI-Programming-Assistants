#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <cctype>

using namespace std;

class Solution {
public:
    vector<char> findMostFrequentVowelAndConsonant(string s) {
        unordered_map<char, int> vowelCount;
        unordered_map<char, int> consonantCount;
        vector<char> vowels = {'a', 'e', 'i', 'o', 'u'};

        for (char c : s) {
            if (!isalpha(c)) continue;
            char lowerC = tolower(c);
            if (find(vowels.begin(), vowels.end(), lowerC) != vowels.end()) {
                vowelCount[lowerC]++;
            } else {
                consonantCount[lowerC]++;
            }
        }

        char maxVowel = 'a';
        int maxVowelCount = 0;
        for (auto& pair : vowelCount) {
            if (pair.second > maxVowelCount || 
                (pair.second == maxVowelCount && pair.first < maxVowel)) {
                maxVowel = pair.first;
                maxVowelCount = pair.second;
            }
        }

        char maxConsonant = 'b';
        int maxConsonantCount = 0;
        for (auto& pair : consonantCount) {
            if (pair.second > maxConsonantCount || 
                (pair.second == maxConsonantCount && pair.first < maxConsonant)) {
                maxConsonant = pair.first;
                maxConsonantCount = pair.second;
            }
        }

        if (maxVowelCount == 0) maxVowel = 'a';
        if (maxConsonantCount == 0) maxConsonant = 'b';

        return {maxVowel, maxConsonant};
    }
};