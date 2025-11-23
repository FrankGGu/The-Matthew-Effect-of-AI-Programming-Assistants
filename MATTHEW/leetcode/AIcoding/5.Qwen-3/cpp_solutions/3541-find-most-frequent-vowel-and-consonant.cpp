#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    vector<char> getVowelConsonantCount(string s) {
        map<char, int> count;
        for (char c : s) {
            if (isalpha(c)) {
                count[tolower(c)]++;
            }
        }

        int maxVowel = 0;
        char mostVowel = 'a';
        int maxConsonant = 0;
        char mostConsonant = 'a';

        for (auto& pair : count) {
            char c = pair.first;
            int freq = pair.second;
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                if (freq > maxVowel) {
                    maxVowel = freq;
                    mostVowel = c;
                }
            } else {
                if (freq > maxConsonant) {
                    maxConsonant = freq;
                    mostConsonant = c;
                }
            }
        }

        vector<char> result;
        result.push_back(mostVowel);
        result.push_back(mostConsonant);
        return result;
    }
};