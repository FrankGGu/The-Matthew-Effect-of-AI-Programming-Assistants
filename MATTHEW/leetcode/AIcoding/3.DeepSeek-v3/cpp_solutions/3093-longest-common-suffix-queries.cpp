#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> stringIndices(vector<string>& wordsContainer, vector<string>& wordsQuery) {
        unordered_map<string, pair<int, int>> suffixMap;
        for (int i = 0; i < wordsContainer.size(); ++i) {
            string word = wordsContainer[i];
            for (int j = 0; j <= word.size(); ++j) {
                string suffix = word.substr(word.size() - j);
                if (suffixMap.find(suffix) == suffixMap.end() || 
                    word.size() < suffixMap[suffix].second || 
                    (word.size() == suffixMap[suffix].second && i < suffixMap[suffix].first)) {
                    suffixMap[suffix] = {i, word.size()};
                }
            }
        }

        vector<int> result;
        for (string& query : wordsQuery) {
            int bestIndex = 0;
            int bestLength = wordsContainer[0].size();
            for (int j = 1; j <= query.size(); ++j) {
                string suffix = query.substr(query.size() - j);
                if (suffixMap.find(suffix) != suffixMap.end()) {
                    auto& p = suffixMap[suffix];
                    if (p.second < bestLength || (p.second == bestLength && p.first < bestIndex)) {
                        bestIndex = p.first;
                        bestLength = p.second;
                    }
                }
            }
            result.push_back(bestIndex);
        }
        return result;
    }
};