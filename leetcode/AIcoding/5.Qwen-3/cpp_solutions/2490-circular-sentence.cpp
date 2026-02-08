#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isCircularSentence(string sentence) {
        vector<string> words;
        string word;
        for (char c : sentence) {
            if (c == ' ') {
                words.push_back(word);
                word = "";
            } else {
                word += c;
            }
        }
        words.push_back(word);

        for (int i = 0; i < words.size(); ++i) {
            int j = (i + 1) % words.size();
            if (words[i].back() != words[j].front()) {
                return false;
            }
        }
        return true;
    }
};