#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string oddString(vector<string>& words) {
        unordered_map<string, int> diffCounts;
        unordered_map<string, string> diffToWord;
        for (string& word : words) {
            string diff = "";
            for (int i = 1; i < word.length(); ++i) {
                diff += to_string(word[i] - word[i - 1]) + ",";
            }
            diffCounts[diff]++;
            diffToWord[diff] = word;
        }

        for (auto const& [diff, count] : diffCounts) {
            if (count == 1) {
                return diffToWord[diff];
            }
        }
        return "";
    }
};