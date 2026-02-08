class Solution {
public:
    int countKeys(string keys, string target) {
        vector<int> count(26, 0);
        for (char c : keys) {
            count[c - 'a']++;
        }

        vector<int> targetCount(26, 0);
        for (char c : target) {
            targetCount[c - 'a']++;
        }

        int minKeys = INT_MAX;
        for (int i = 0; i < 26; i++) {
            if (targetCount[i] > 0) {
                minKeys = min(minKeys, count[i] / targetCount[i]);
            }
        }

        return minKeys == INT_MAX ? 0 : minKeys;
    }
};