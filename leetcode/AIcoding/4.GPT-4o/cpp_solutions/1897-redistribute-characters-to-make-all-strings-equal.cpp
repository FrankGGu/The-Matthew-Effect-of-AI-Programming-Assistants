class Solution {
public:
    bool makeEqual(vector<string>& words) {
        int totalChars = 0;
        vector<int> charCount(26, 0);

        for (const string& word : words) {
            totalChars += word.size();
            for (char c : word) {
                charCount[c - 'a']++;
            }
        }

        if (totalChars % words.size() != 0) return false;

        int target = totalChars / words.size();
        for (int count : charCount) {
            if (count % target != 0) return false;
        }

        return true;
    }
};