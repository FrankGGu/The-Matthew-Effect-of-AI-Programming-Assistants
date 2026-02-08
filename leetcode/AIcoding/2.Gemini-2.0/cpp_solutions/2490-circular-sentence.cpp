#include <string>
#include <vector>
#include <sstream>

using namespace std;

class Solution {
public:
    bool isCircularSentence(string sentence) {
        stringstream ss(sentence);
        string word;
        vector<string> words;
        while (ss >> word) {
            words.push_back(word);
        }

        int n = words.size();
        for (int i = 0; i < n - 1; ++i) {
            if (words[i].back() != words[i + 1].front()) {
                return false;
            }
        }

        return words.back().back() == words[0].front();
    }
};