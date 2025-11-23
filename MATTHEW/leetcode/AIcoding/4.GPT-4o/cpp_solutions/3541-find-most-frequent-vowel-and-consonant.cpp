#include <unordered_map>
#include <vector>
#include <string>
using namespace std;

vector<string> mostFrequent(string s) {
    unordered_map<char, int> vowelCount, consonantCount;
    string vowels = "aeiou";

    for (char c : s) {
        c = tolower(c);
        if (isalpha(c)) {
            if (vowels.find(c) != string::npos) {
                vowelCount[c]++;
            } else {
                consonantCount[c]++;
            }
        }
    }

    char mostFrequentVowel = ' ';
    int maxVowelCount = 0;
    for (auto& pair : vowelCount) {
        if (pair.second > maxVowelCount || (pair.second == maxVowelCount && pair.first < mostFrequentVowel)) {
            mostFrequentVowel = pair.first;
            maxVowelCount = pair.second;
        }
    }

    char mostFrequentConsonant = ' ';
    int maxConsonantCount = 0;
    for (auto& pair : consonantCount) {
        if (pair.second > maxConsonantCount || (pair.second == maxConsonantCount && pair.first < mostFrequentConsonant)) {
            mostFrequentConsonant = pair.first;
            maxConsonantCount = pair.second;
        }
    }

    return {string(1, mostFrequentVowel), string(1, mostFrequentConsonant)};
}