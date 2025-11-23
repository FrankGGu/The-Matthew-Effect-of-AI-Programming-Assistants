#include <string>
#include <vector>

class MagicDictionary {
public:
    std::vector<std::string> dictWords;

    MagicDictionary() {

    }

    void buildDict(std::vector<std::string> dictionary) {
        dictWords = dictionary;
    }

    bool search(std::string searchWord) {
        for (const std::string& dictWord : dictWords) {
            if (dictWord.length() != searchWord.length()) {
                continue;
            }

            int diffCount = 0;
            for (int i = 0; i < dictWord.length(); ++i) {
                if (dictWord[i] != searchWord[i]) {
                    diffCount++;
                }
                if (diffCount > 1) {
                    break;
                }
            }

            if (diffCount == 1) {
                return true;
            }
        }
        return false;
    }
};