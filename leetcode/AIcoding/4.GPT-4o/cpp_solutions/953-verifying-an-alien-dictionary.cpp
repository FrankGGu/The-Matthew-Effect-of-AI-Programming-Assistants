class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> charOrder;
        for (int i = 0; i < order.size(); ++i) {
            charOrder[order[i]] = i;
        }

        for (int i = 1; i < words.size(); ++i) {
            if (!isValid(words[i - 1], words[i], charOrder)) {
                return false;
            }
        }

        return true;
    }

private:
    bool isValid(const string& word1, const string& word2, const unordered_map<char, int>& charOrder) {
        int len1 = word1.size(), len2 = word2.size();
        for (int i = 0; i < min(len1, len2); ++i) {
            if (word1[i] != word2[i]) {
                return charOrder.at(word1[i]) < charOrder.at(word2[i]);
            }
        }
        return len1 <= len2;
    }
};