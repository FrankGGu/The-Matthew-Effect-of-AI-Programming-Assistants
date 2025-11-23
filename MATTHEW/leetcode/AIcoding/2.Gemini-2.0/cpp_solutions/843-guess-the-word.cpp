class Solution {
public:
    void findSecretWord(vector<string>& wordlist, Master& master) {
        srand(time(nullptr));
        for (int i = 0; i < 10; ++i) {
            string guess_word = wordlist[rand() % wordlist.size()];
            int matches = master.guess(guess_word);
            if (matches == 6) return;

            vector<string> new_wordlist;
            for (const string& word : wordlist) {
                int common = 0;
                for (int j = 0; j < 6; ++j) {
                    if (word[j] == guess_word[j]) {
                        common++;
                    }
                }
                if (common == matches) {
                    new_wordlist.push_back(word);
                }
            }
            wordlist = new_wordlist;
        }
    }
};