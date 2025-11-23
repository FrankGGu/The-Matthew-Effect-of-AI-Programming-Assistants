#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> getSequence(vector<string> &words, vector<int> &order) {
        unordered_map<char, int> charToIndex;
        for (int i = 0; i < order.size(); ++i) {
            charToIndex[words[order[i]]] = i;
        }

        vector<string> result;
        for (int i = 0; i < words.size(); ++i) {
            result.push_back(words[i]);
        }

        sort(result.begin(), result.end(), [&](const string &a, const string &b) {
            return charToIndex[a] < charToIndex[b];
        });

        return result;
    }
};