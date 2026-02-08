#include <vector>
#include <string>
#include <sstream>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        unordered_set<string> dictSet(dictionary.begin(), dictionary.end());
        stringstream ss(sentence);
        string word, res = "";
        while (ss >> word) {
            string root = "";
            for (int i = 1; i <= word.length(); ++i) {
                string prefix = word.substr(0, i);
                if (dictSet.count(prefix)) {
                    root = prefix;
                    break;
                }
            }
            if (root.empty()) {
                res += word + " ";
            } else {
                res += root + " ";
            }
        }
        res.pop_back();
        return res;
    }
};