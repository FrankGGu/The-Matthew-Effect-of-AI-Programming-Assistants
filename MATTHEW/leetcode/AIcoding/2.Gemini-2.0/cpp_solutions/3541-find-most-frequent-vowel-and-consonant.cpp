#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string mostFrequentVowelAndConsonant(string s) {
        unordered_map<char, int> vowelCount;
        unordered_map<char, int> consonantCount;

        for (char c : s) {
            c = tolower(c);
            if (c >= 'a' && c <= 'z') {
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    vowelCount[c]++;
                } else {
                    consonantCount[c]++;
                }
            }
        }

        char mostFrequentVowel = '\0';
        int maxVowelCount = 0;
        for (auto const& [key, val] : vowelCount) {
            if (val > maxVowelCount) {
                maxVowelCount = val;
                mostFrequentVowel = key;
            }
        }

        char mostFrequentConsonant = '\0';
        int maxConsonantCount = 0;
        for (auto const& [key, val] : consonantCount) {
            if (val > maxConsonantCount) {
                maxConsonantCount = val;
                mostFrequentConsonant = key;
            }
        }

        string result = "";
        if (mostFrequentVowel != '\0') {
            result += mostFrequentVowel;
        }
        if (mostFrequentConsonant != '\0') {
            result += mostFrequentConsonant;
        }

        return result;
    }
};