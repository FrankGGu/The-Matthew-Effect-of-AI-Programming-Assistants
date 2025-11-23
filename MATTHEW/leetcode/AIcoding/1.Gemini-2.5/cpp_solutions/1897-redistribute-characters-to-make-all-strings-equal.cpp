class Solution {
public:
    bool makeEqual(std::vector<std::string>& words) {
        std::vector<int> char_counts(26, 0);
        int num_words = words.size();

        for (const std::string& word : words) {
            for (char c : word) {
                char_counts[c - 'a']++;
            }
        }

        for (int count : char_counts) {
            if (count % num_words != 0) {
                return false;
            }
        }

        return true;
    }
};