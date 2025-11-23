#include <string>
#include <vector>
#include <unordered_set>

class MagicDictionary {
private:
    std::unordered_set<std::string> dict_words;

public:
    MagicDictionary() {

    }

    void buildDict(std::vector<std::string> dictionary) {
        for (const std::string& word : dictionary) {
            dict_words.insert(word);
        }
    }

    bool search(std::string searchWord) {
        for (const std::string& dict_word : dict_words) {
            if (dict_word.length() != searchWord.length()) {
                continue;
            }

            int diff_count = 0;
            for (int i = 0; i < dict_word.length(); ++i) {
                if (dict_word[i] != searchWord[i]) {
                    diff_count++;
                }
                if (diff_count > 1) {
                    break; 
                }
            }

            if (diff_count == 1) {
                return true;
            }
        }
        return false;
    }
};