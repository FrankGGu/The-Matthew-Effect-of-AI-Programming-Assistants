class Solution {
public:
    int maxFreq(string s, int maxLetters, int minSize, int maxSize) {
        unordered_map<string, int> freq;
        int maxCount = 0;
        int n = s.size();

        for (int i = 0; i <= n - minSize; ++i) {
            string sub = s.substr(i, minSize);
            unordered_set<char> uniqueChars(sub.begin(), sub.end());
            if (uniqueChars.size() <= maxLetters) {
                freq[sub]++;
                maxCount = max(maxCount, freq[sub]);
            }
        }

        return maxCount;
    }
};