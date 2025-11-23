class MagicDictionary {
public:
    unordered_set<string> words;

    MagicDictionary() {}

    void buildDict(vector<string> dictionary) {
        for (const string& word : dictionary) {
            words.insert(word);
        }
    }

    bool search(string searchWord) {
        for (int i = 0; i < searchWord.size(); ++i) {
            char originalChar = searchWord[i];
            for (char c = 'a'; c <= 'z'; ++c) {
                if (c != originalChar) {
                    searchWord[i] = c;
                    if (words.count(searchWord)) {
                        return true;
                    }
                }
            }
            searchWord[i] = originalChar;
        }
        return false;
    }
};