#include <string>
#include <vector>
#include <sstream>

using namespace std;

class Solution {
public:
    string reorderSpaces(string text) {
        int spaces = 0;
        vector<string> words;
        stringstream ss(text);
        string word;

        for (char c : text) {
            if (c == ' ') {
                spaces++;
            }
        }

        while (ss >> word) {
            words.push_back(word);
        }

        if (words.size() == 1) {
            return words[0] + string(spaces, ' ');
        }

        int spacesBetween = (words.size() > 1) ? spaces / (words.size() - 1) : spaces;
        int trailingSpaces = (words.size() > 1) ? spaces % (words.size() - 1) : spaces;

        string result = words[0];
        for (int i = 1; i < words.size(); ++i) {
            result += string(spacesBetween, ' ') + words[i];
        }
        result += string(trailingSpaces, ' ');

        return result;
    }
};