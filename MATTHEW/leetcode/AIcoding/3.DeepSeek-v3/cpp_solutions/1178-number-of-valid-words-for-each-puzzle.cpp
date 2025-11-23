class Solution {
public:
    vector<int> findNumOfValidWords(vector<string>& words, vector<string>& puzzles) {
        unordered_map<int, int> freq;
        for (const string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= 1 << (c - 'a');
            }
            freq[mask]++;
        }

        vector<int> res;
        for (const string& puzzle : puzzles) {
            int total = 0;
            int mask = 0;
            for (int i = 1; i < 7; ++i) {
                mask |= 1 << (puzzle[i] - 'a');
            }
            int subset = mask;
            while (subset) {
                int s = subset | (1 << (puzzle[0] - 'a'));
                if (freq.count(s)) {
                    total += freq[s];
                }
                subset = (subset - 1) & mask;
            }
            int s = 1 << (puzzle[0] - 'a');
            if (freq.count(s)) {
                total += freq[s];
            }
            res.push_back(total);
        }
        return res;
    }
};