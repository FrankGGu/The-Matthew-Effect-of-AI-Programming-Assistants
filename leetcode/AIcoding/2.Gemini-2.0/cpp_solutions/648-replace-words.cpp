#include <vector>
#include <string>
#include <sstream>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        unordered_set<string> dict_set(dictionary.begin(), dictionary.end());
        stringstream ss(sentence);
        string word;
        string result = "";
        while (ss >> word) {
            string prefix = "";
            for (int i = 1; i <= word.length(); ++i) {
                prefix = word.substr(0, i);
                if (dict_set.count(prefix)) {
                    word = prefix;
                    break;
                }
            }
            result += word + " ";
        }
        result.pop_back();
        return result;
    }
};