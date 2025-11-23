#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string sortVowels(string s) {
        vector<char> vowels;
        string vowel_chars = "AEIOUaeiou";
        for (char c : s) {
            if (vowel_chars.find(c) != string::npos) {
                vowels.push_back(c);
            }
        }
        sort(vowels.begin(), vowels.end());
        int vowel_index = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (vowel_chars.find(s[i]) != string::npos) {
                s[i] = vowels[vowel_index++];
            }
        }
        return s;
    }
};