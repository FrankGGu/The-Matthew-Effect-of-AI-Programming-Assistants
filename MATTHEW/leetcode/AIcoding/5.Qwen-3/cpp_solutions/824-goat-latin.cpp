#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    string toGoatLatin(string sentence) {
        stringstream ss(sentence);
        string word, result;
        int count = 1;
        while (ss >> word) {
            char first = tolower(word[0]);
            if (first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u') {
                result += word + "ma";
            } else {
                result += word.substr(1) + word[0] + "ma";
            }
            for (int i = 0; i < count; ++i) {
                result += "a";
            }
            if (count != 1) {
                result += " ";
            }
            ++count;
        }
        return result;
    }
};