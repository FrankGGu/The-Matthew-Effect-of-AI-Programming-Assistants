#include <vector>
#include <string>

using namespace std;

class MagicDictionary {
public:
    vector<string> dict;

    MagicDictionary() {

    }

    void buildDict(vector<string> dictionary) {
        dict = dictionary;
    }

    bool search(string searchWord) {
        for (string word : dict) {
            if (word.length() != searchWord.length()) continue;
            int diff = 0;
            for (int i = 0; i < word.length(); i++) {
                if (word[i] != searchWord[i]) diff++;
            }
            if (diff == 1) return true;
        }
        return false;
    }
};