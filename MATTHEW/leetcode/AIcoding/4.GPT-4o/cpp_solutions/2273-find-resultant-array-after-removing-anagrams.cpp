#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> removeAnagrams(vector<string>& words) {
        vector<string> result;
        unordered_map<string, string> mp;

        for (const string& word : words) {
            string sortedWord = word;
            sort(sortedWord.begin(), sortedWord.end());
            if (mp.find(sortedWord) == mp.end()) {
                mp[sortedWord] = word;
                result.push_back(word);
            }
        }
        return result;
    }
};