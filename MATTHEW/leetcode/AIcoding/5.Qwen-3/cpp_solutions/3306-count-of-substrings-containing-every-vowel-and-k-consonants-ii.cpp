#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countOfSubstrings(string s, int k) {
        int n = s.length();
        int result = 0;
        unordered_map<char, int> vowelCount;
        int vowels = 0;

        for (int i = 0; i < n; ++i) {
            if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                vowelCount[s[i]]++;
                if (vowelCount[s[i]] == 1) {
                    vowels++;
                }
            }
        }

        int left = 0;
        int right = 0;
        unordered_map<char, int> currentVowelCount;
        int currentVowels = 0;
        int consonants = 0;

        while (right < n) {
            char c = s[right];
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                currentVowelCount[c]++;
                if (currentVowelCount[c] == 1) {
                    currentVowels++;
                }
            } else {
                consonants++;
            }

            while (currentVowels == 5 && consonants >= k) {
                result++;
                char leftChar = s[left];
                if (leftChar == 'a' || leftChar == 'e' || leftChar == 'i' || leftChar == 'o' || leftChar == 'u') {
                    currentVowelCount[leftChar]--;
                    if (currentVowelCount[leftChar] == 0) {
                        currentVowels--;
                    }
                } else {
                    consonants--;
                }
                left++;
            }
            right++;
        }

        return result;
    }
};