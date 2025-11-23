#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reorderSpaces(const string& text) {
        vector<string> words;
        string word;
        int spaceCount = 0;

        for (char c : text) {
            if (c == ' ') {
                spaceCount++;
                if (!word.empty()) {
                    words.push_back(word);
                    word.clear();
                }
            } else {
                word += c;
            }
        }

        if (!word.empty()) {
            words.push_back(word);
        }

        if (words.size() == 1) {
            return words[0] + string(spaceCount, ' ');
        }

        int totalSpace = spaceCount;
        int gap = totalSpace / (words.size() - 1);
        int remainder = totalSpace % (words.size() - 1);

        string result;
        for (int i = 0; i < words.size(); ++i) {
            result += words[i];
            if (i < words.size() - 1) {
                result += string(gap, ' ');
                if (remainder > 0) {
                    result += ' ';
                    remainder--;
                }
            }
        }

        return result;
    }
};