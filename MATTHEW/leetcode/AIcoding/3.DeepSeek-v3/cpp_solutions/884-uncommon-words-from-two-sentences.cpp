#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> uncommonFromSentences(string s1, string s2) {
        unordered_map<string, int> freq;
        istringstream iss(s1 + " " + s2);
        string word;
        while (iss >> word) {
            freq[word]++;
        }
        vector<string> result;
        for (const auto& [word, count] : freq) {
            if (count == 1) {
                result.push_back(word);
            }
        }
        return result;
    }
};