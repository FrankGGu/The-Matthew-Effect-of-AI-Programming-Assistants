class Solution {
public:
    int countCharacters(vector<string>& words, string chars) {
        unordered_map<char, int> charCount;
        for (char c : chars) {
            charCount[c]++;
        }

        int totalLength = 0;
        for (const string& word : words) {
            unordered_map<char, int> wordCount;
            for (char c : word) {
                wordCount[c]++;
            }

            bool canForm = true;
            for (const auto& entry : wordCount) {
                if (charCount[entry.first] < entry.second) {
                    canForm = false;
                    break;
                }
            }

            if (canForm) {
                totalLength += word.length();
            }
        }

        return totalLength;
    }
};