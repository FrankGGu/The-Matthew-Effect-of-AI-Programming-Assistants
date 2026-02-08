#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        unordered_map<string, vector<string>> anagrams;
        for (const string& str : strs) {
            string key = str;
            sort(key.begin(), key.end());
            anagrams[key].push_back(str);
        }
        vector<vector<string>> result;
        for (auto& pair : anagrams) {
            result.push_back(pair.second);
        }
        return result;
    }
};