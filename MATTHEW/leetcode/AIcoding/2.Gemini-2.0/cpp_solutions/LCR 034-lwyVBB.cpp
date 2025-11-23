#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        vector<int> order_map(26);
        for (int i = 0; i < order.length(); ++i) {
            order_map[order[i] - 'a'] = i;
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string word1 = words[i];
            string word2 = words[i + 1];
            int len1 = word1.length();
            int len2 = word2.length();
            int j = 0;
            while (j < len1 && j < len2) {
                if (order_map[word1[j] - 'a'] < order_map[word2[j] - 'a']) {
                    break;
                } else if (order_map[word1[j] - 'a'] > order_map[word2[j] - 'a']) {
                    return false;
                }
                j++;
            }
            if (j == len2 && j < len1) {
                return false;
            }
        }
        return true;
    }
};