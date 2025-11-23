#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> order_map;
        for (int i = 0; i < order.length(); ++i) {
            order_map[order[i]] = i;
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string word1 = words[i];
            string word2 = words[i + 1];
            int len1 = word1.length();
            int len2 = word2.length();
            int j = 0;
            while (j < min(len1, len2)) {
                if (order_map[word1[j]] < order_map[word2[j]]) {
                    break;
                } else if (order_map[word1[j]] > order_map[word2[j]]) {
                    return false;
                }
                ++j;
            }
            if (j == min(len1, len2) && len1 > len2) {
                return false;
            }
        }

        return true;
    }
};