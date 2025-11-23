#include <string>
#include <sstream>
#include <vector>

using namespace std;

class Solution {
public:
    string truncateSentence(string s, int k) {
        stringstream ss(s);
        string word;
        vector<string> words;
        while (ss >> word) {
            words.push_back(word);
        }
        string result = "";
        for (int i = 0; i < min((int)words.size(), k); ++i) {
            result += words[i];
            if (i < min((int)words.size(), k) - 1) {
                result += " ";
            }
        }
        return result;
    }
};