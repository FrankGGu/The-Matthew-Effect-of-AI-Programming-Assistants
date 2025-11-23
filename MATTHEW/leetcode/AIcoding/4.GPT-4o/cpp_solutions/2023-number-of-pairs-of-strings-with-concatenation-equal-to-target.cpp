class Solution {
public:
    int countPairs(vector<string>& words, string target) {
        unordered_map<string, int> wordCount;
        int count = 0;

        for (const auto& word : words) {
            wordCount[word]++;
        }

        for (const auto& word : words) {
            string complement = target.substr(0, target.size() - word.size());
            if (word.size() < target.size() && wordCount.count(complement)) {
                count += wordCount[complement];
                if (complement == word) {
                    count--; // Avoid double counting
                }
            }
        }

        return count / 2; // Each pair is counted twice
    }
};