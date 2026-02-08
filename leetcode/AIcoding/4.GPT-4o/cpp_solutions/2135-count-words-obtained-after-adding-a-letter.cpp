class Solution {
public:
    int countWords(vector<string>& startWords, vector<string>& targetWords) {
        unordered_set<int> startSet;
        for (const string& word : startWords) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            startSet.insert(mask);
        }

        int count = 0;
        for (const string& word : targetWords) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            for (char c : word) {
                int newMask = mask & ~(1 << (c - 'a'));
                if (startSet.count(newMask)) {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
};