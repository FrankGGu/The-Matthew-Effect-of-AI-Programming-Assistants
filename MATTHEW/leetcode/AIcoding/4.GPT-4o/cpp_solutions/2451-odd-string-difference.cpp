#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string oddString(vector<string>& words) {
        unordered_map<string, int> diffMap;
        for (const string& word : words) {
            string diff;
            for (int i = 1; i < word.size(); ++i) {
                diff += to_string(word[i] - word[i - 1]) + ",";
            }
            diffMap[diff]++;
        }
        for (const string& word : words) {
            string diff;
            for (int i = 1; i < word.size(); ++i) {
                diff += to_string(word[i] - word[i - 1]) + ",";
            }
            if (diffMap[diff] == 1) {
                return word;
            }
        }
        return "";
    }
};