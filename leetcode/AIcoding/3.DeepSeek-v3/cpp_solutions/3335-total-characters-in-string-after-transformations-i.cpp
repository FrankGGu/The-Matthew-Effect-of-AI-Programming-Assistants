class Solution {
public:
    int totalCharacters(vector<string>& words) {
        vector<int> total(26, 0);
        for (const string& word : words) {
            for (char c : word) {
                total[c - 'a']++;
            }
        }
        int maxCount = 0;
        for (int count : total) {
            if (count > maxCount) {
                maxCount = count;
            }
        }
        return maxCount;
    }
};