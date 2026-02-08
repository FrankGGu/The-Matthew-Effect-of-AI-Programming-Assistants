#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string firstPalindrome(vector<string>& words) {
        for (string word : words) {
            string reversed_word = word;
            reverse(reversed_word.begin(), reversed_word.end());
            if (word == reversed_word) {
                return word;
            }
        }
        return "";
    }
};