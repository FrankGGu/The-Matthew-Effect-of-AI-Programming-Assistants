#include <vector>
#include <unordered_map>
#include <string>
using namespace std;

class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> orderMap;
        for (int i = 0; i < order.size(); i++) {
            orderMap[order[i]] = i;
        }

        for (int i = 0; i < words.size() - 1; i++) {
            string word1 = words[i];
            string word2 = words[i+1];
            int minLen = min(word1.size(), word2.size());
            bool foundDifference = false;
            for (int j = 0; j < minLen; j++) {
                if (word1[j] != word2[j]) {
                    if (orderMap[word1[j]] > orderMap[word2[j]]) {
                        return false;
                    }
                    foundDifference = true;
                    break;
                }
            }
            if (!foundDifference && word1.size() > word2.size()) {
                return false;
            }
        }
        return true;
    }
};