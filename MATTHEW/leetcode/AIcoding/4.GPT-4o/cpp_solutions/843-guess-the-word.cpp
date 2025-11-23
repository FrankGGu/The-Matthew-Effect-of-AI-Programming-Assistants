class Solution {
public:
    void findSecretWord(vector<string>& wordlist, Master& master) {
        int n = wordlist.size();
        vector<int> count(6, 0);
        int guessCount = 0;

        while (guessCount < 10) {
            string guess = wordlist[0];
            int matches = master.guess(guess);
            if (matches == 6) return;

            vector<string> newWordlist;
            for (const string& word : wordlist) {
                if (match(guess, word) == matches) {
                    newWordlist.push_back(word);
                }
            }
            wordlist = newWordlist;
            guessCount++;
        }
    }

    int match(const string& a, const string& b) {
        int count = 0;
        for (int i = 0; i < 6; ++i) {
            if (a[i] == b[i]) {
                count++;
            }
        }
        return count;
    }
};