class Solution {
public:
    void findSecretWord(vector<string>& wordlist, Master& master) {
        vector<string> candidates = wordlist;
        while (!candidates.empty()) {
            string guessWord = candidates[rand() % candidates.size()];
            int matches = master.guess(guessWord);
            if (matches == 6) return;
            vector<string> newCandidates;
            for (string word : candidates) {
                if (countMatches(guessWord, word) == matches) {
                    newCandidates.push_back(word);
                }
            }
            candidates = newCandidates;
        }
    }

private:
    int countMatches(const string& a, const string& b) {
        int matches = 0;
        for (int i = 0; i < a.size(); ++i) {
            if (a[i] == b[i]) ++matches;
        }
        return matches;
    }
};