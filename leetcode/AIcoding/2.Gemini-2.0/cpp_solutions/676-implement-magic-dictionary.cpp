#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class MagicDictionary {
public:
    MagicDictionary() {

    }

    void buildDict(vector<string> dictionary) {
        words = dictionary;
    }

    bool search(string searchWord) {
        for (string word : words) {
            if (word.length() != searchWord.length()) continue;
            int diff = 0;
            for (int i = 0; i < word.length(); ++i) {
                if (word[i] != searchWord[i]) {
                    diff++;
                }
            }
            if (diff == 1) return true;
        }
        return false;
    }

private:
    vector<string> words;
};