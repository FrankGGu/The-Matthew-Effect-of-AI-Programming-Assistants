class Solution {
public:
    int countCompleteSubstrings(string s) {
        int n = s.size();
        int completeCount = 0;
        unordered_set<char> uniqueChars(s.begin(), s.end());
        int uniqueCount = uniqueChars.size();

        for (int i = 0; i < n; i++) {
            unordered_map<char, int> charCount;
            int currentUniqueCount = 0;
            for (int j = i; j < n; j++) {
                charCount[s[j]]++;
                if (charCount[s[j]] == 1) {
                    currentUniqueCount++;
                }
                if (currentUniqueCount == uniqueCount) {
                    completeCount++;
                }
            }
        }

        return completeCount;
    }
};