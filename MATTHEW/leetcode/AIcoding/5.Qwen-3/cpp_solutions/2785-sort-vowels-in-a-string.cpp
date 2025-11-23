#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string sortVowels(string s) {
        vector<char> vowels;
        for (char c : s) {
            if (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U' ||
                c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels.push_back(c);
            }
        }
        sort(vowels.begin(), vowels.end());
        int vowelIndex = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U' ||
                s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                s[i] = vowels[vowelIndex++];
            }
        }
        return s;
    }
};