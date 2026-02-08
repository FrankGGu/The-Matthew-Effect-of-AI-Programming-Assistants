class Solution {
public:
    int countPalindromicPairs(vector<string>& words) {
        unordered_map<string, int> prefixCount, suffixCount;
        int result = 0;

        for (const auto& word : words) {
            string revWord = word;
            reverse(revWord.begin(), revWord.end());
            prefixCount[word]++;
            suffixCount[revWord]++;
        }

        for (const auto& [word, count] : prefixCount) {
            string revWord = word;
            reverse(revWord.begin(), revWord.end());
            if (suffixCount.find(revWord) != suffixCount.end()) {
                result += count * suffixCount[revWord];
            }
        }

        return result;
    }
};