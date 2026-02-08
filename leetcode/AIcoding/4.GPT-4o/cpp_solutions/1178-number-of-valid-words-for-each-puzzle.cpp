class Solution {
public:
    vector<int> findNumOfValidWords(vector<string>& words, vector<string>& puzzles) {
        unordered_map<int, int> wordCount;
        for (const string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            wordCount[mask]++;
        }

        vector<int> result;
        for (const string& puzzle : puzzles) {
            int mask = 0;
            for (char c : puzzle) {
                mask |= (1 << (c - 'a'));
            }

            int firstCharMask = 1 << (puzzle[0] - 'a');
            int count = 0;
            for (int submask = mask; submask > 0; submask = (submask - 1) & mask) {
                if (submask & firstCharMask) {
                    count += wordCount[submask];
                }
            }
            result.push_back(count);
        }

        return result;
    }
};