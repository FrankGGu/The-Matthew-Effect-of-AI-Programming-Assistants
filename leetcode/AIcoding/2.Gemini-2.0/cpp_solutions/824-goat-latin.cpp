#include <string>
#include <sstream>
#include <vector>

using namespace std;

class Solution {
public:
    string toGoatLatin(string sentence) {
        stringstream ss(sentence);
        string word;
        string result = "";
        int word_count = 1;

        while (ss >> word) {
            char first_char = tolower(word[0]);
            if (first_char == 'a' || first_char == 'e' || first_char == 'i' || first_char == 'o' || first_char == 'u') {
                result += word;
            } else {
                result += word.substr(1) + word[0];
            }
            result += "ma";

            for (int i = 0; i < word_count; ++i) {
                result += 'a';
            }

            result += ' ';
            word_count++;
        }

        result.pop_back();
        return result;
    }
};