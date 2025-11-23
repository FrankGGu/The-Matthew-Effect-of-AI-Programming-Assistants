class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        unordered_map<char, int> charOrder;
        for (int i = 0; i < order.size(); ++i) {
            charOrder[order[i]] = i;
        }

        for (int i = 1; i < words.size(); ++i) {
            if (!isInOrder(words[i - 1], words[i], charOrder)) {
                return false;
            }
        }
        return true;
    }

private:
    bool isInOrder(const string& word1, const string& word2, const unordered_map<char, int>& charOrder) {
        int minLength = min(word1.size(), word2.size());
        for (int i = 0; i < minLength; ++i) {
            if (word1[i] != word2[i]) {
                return charOrder.at(word1[i]) < charOrder.at(word2[i]);
            }
        }
        return word1.size() <= word2.size();
    }
};