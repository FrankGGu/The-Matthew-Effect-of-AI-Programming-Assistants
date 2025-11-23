#include <string>
#include <vector>
#include <sstream>

using namespace std;

class Solution {
public:
    int countValidWords(string sentence) {
        int count = 0;
        stringstream ss(sentence);
        string word;
        while (ss >> word) {
            if (isValid(word)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isValid(string word) {
        int hyphenCount = 0;
        for (int i = 0; i < word.length(); ++i) {
            if (isdigit(word[i])) {
                return false;
            }
            if (word[i] == '-') {
                hyphenCount++;
                if (hyphenCount > 1) {
                    return false;
                }
                if (i == 0 || i == word.length() - 1) {
                    return false;
                }
                if (!isalpha(word[i - 1]) || !isalpha(word[i + 1])) {
                    return false;
                }
            }
            if (word[i] == '!' || word[i] == '.' || word[i] == ',') {
                if (i != word.length() - 1) {
                    return false;
                }
            }
        }
        return true;
    }
};