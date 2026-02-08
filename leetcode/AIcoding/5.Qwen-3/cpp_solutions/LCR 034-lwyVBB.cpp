#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> orderIndex;
        for (int i = 0; i < order.size(); ++i) {
            orderIndex[order[i]] = i;
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string word1 = words[i];
            string word2 = words[i + 1];

            for (int j = 0; j < min(word1.size(), word2.size()); ++j) {
                char c1 = word1[j];
                char c2 = word2[j];

                if (c1 != c2) {
                    if (orderIndex[c1] > orderIndex[c2]) {
                        return false;
                    }
                    break;
                }
            }
        }

        return true;
    }
};