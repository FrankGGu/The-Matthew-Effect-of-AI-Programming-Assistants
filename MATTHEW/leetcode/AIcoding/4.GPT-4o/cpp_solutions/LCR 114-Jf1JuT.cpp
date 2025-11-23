class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> order_map;
        for (int i = 0; i < order.size(); ++i) {
            order_map[order[i]] = i;
        }

        for (int i = 1; i < words.size(); ++i) {
            if (!isSorted(words[i - 1], words[i], order_map)) {
                return false;
            }
        }
        return true;
    }

private:
    bool isSorted(const string& word1, const string& word2, const unordered_map<char, int>& order_map) {
        int len1 = word1.size(), len2 = word2.size();
        int min_len = min(len1, len2);

        for (int i = 0; i < min_len; ++i) {
            if (word1[i] != word2[i]) {
                return order_map.at(word1[i]) < order_map.at(word2[i]);
            }
        }
        return len1 <= len2;
    }
};