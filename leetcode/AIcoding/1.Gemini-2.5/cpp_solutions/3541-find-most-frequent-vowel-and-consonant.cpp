#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string findMostFrequentVowelAndConsonant(std::string s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            if (c >= 'a' && c <= 'z') {
                freq[c - 'a']++;
            }
        }

        char most_freq_vowel = ' ';
        int max_vowel_freq = 0;

        const char vowels[] = {'a', 'e', 'i', 'o', 'u'};
        for (char v : vowels) {
            if (freq[v - 'a'] > max_vowel_freq) {
                max_vowel_freq = freq[v - 'a'];
                most_freq_vowel = v;
            }
        }

        char most_freq_consonant = ' ';
        int max_consonant_freq = 0;

        for (char c = 'a'; c <= 'z'; ++c) {
            bool is_vowel = (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
            if (!is_vowel) {
                if (freq[c - 'a'] > max_consonant_freq) {
                    max_consonant_freq = freq[c - 'a'];
                    most_freq_consonant = c;
                }
            }
        }

        std::string result = "";
        if (max_vowel_freq > 0) {
            result += most_freq_vowel;
        }
        if (max_consonant_freq > 0) {
            result += most_freq_consonant;
        }

        return result;
    }
};