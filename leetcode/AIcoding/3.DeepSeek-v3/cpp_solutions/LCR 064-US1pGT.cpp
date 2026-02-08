class MagicDictionary {
private:
    vector<string> dict;
public:
    MagicDictionary() {}

    void buildDict(vector<string> dictionary) {
        dict = dictionary;
    }

    bool search(string searchWord) {
        for (const string& word : dict) {
            if (word.size() != searchWord.size()) continue;
            int diff = 0;
            for (int i = 0; i < word.size(); ++i) {
                if (word[i] != searchWord[i]) {
                    ++diff;
                    if (diff > 1) break;
                }
            }
            if (diff == 1) return true;
        }
        return false;
    }
};