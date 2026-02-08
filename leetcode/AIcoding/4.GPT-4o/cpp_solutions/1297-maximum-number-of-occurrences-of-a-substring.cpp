class Solution {
public:
    int maxFreq(string s, int maxLetters, int minSize, int maxSize) {
        unordered_map<string, int> count;
        int maxCount = 0;

        for (int size = minSize; size <= maxSize; ++size) {
            for (int i = 0; i + size <= s.size(); ++i) {
                string sub = s.substr(i, size);
                if (uniqueLetters(sub) <= maxLetters) {
                    count[sub]++;
                    maxCount = max(maxCount, count[sub]);
                }
            }
        }

        return maxCount;
    }

private:
    int uniqueLetters(const string& sub) {
        unordered_set<char> uniqueChars(sub.begin(), sub.end());
        return uniqueChars.size();
    }
};