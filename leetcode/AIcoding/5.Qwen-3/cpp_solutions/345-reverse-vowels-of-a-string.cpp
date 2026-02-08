#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string reverseVowels(string s) {
        vector<int> indices;
        vector<char> vowels;
        for (int i = 0; i < s.length(); ++i) {
            char c = tolower(s[i]);
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                indices.push_back(i);
                vowels.push_back(s[i]);
            }
        }
        for (int i = 0; i < indices.size(); ++i) {
            s[indices[i]] = vowels[vowels.size() - 1 - i];
        }
        return s;
    }
};