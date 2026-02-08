#include <string>
#include <sstream>
#include <vector>

using namespace std;

class Solution {
public:
    string sortSentence(string s) {
        istringstream iss(s);
        string word;
        vector<string> words(9);

        while (iss >> word) {
            int index = word.back() - '0' - 1;
            word.pop_back();
            words[index] = word;
        }

        string result;
        for (const string& w : words) {
            if (!w.empty()) {
                result += w + " ";
            }
        }

        if (!result.empty()) {
            result.pop_back();
        }

        return result;
    }
};