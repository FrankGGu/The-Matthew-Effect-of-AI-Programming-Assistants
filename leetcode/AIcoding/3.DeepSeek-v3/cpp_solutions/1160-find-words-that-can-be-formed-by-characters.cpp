class Solution {
public:
    int countCharacters(vector<string>& words, string chars) {
        vector<int> charCount(26, 0);
        for (char c : chars) {
            charCount[c - 'a']++;
        }

        int result = 0;
        for (const string& word : words) {
            vector<int> tempCount = charCount;
            bool valid = true;
            for (char c : word) {
                if (tempCount[c - 'a'] == 0) {
                    valid = false;
                    break;
                }
                tempCount[c - 'a']--;
            }
            if (valid) {
                result += word.size();
            }
        }
        return result;
    }
};