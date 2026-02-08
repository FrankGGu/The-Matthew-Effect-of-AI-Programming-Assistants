class Solution {
public:
    vector<int> numSmallerByFrequency(vector<string>& queries, vector<string>& words) {
        auto f = [](const string &s) {
            char smallest = 'z';
            int count = 0;
            for (char c : s) {
                if (c < smallest) {
                    smallest = c;
                    count = 1;
                } else if (c == smallest) {
                    ++count;
                }
            }
            return count;
        };

        vector<int> wordFreqs;
        for (const string &word : words) {
            wordFreqs.push_back(f(word));
        }
        sort(wordFreqs.begin(), wordFreqs.end());

        vector<int> result;
        for (const string &query : queries) {
            int queryFreq = f(query);
            auto it = upper_bound(wordFreqs.begin(), wordFreqs.end(), queryFreq);
            result.push_back(wordFreqs.end() - it);
        }
        return result;
    }
};