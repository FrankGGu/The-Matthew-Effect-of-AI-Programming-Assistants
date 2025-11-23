class MagicDictionary {
private:
    unordered_set<string> words;
public:
    MagicDictionary() {

    }

    void buildDict(vector<string> dictionary) {
        for (const string& word : dictionary) {
            words.insert(word);
        }
    }

    bool search(string searchWord) {
        for (int i = 0; i < searchWord.size(); ++i) {
            char original = searchWord[i];
            for (char c = 'a'; c <= 'z'; ++c) {
                if (c == original) continue;
                searchWord[i] = c;
                if (words.count(searchWord)) {
                    return true;
                }
            }
            searchWord[i] = original;
        }
        return false;
    }
};