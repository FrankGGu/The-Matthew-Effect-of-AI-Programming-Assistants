#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Encrypter {
public:
    unordered_map<char, string> encMap;
    unordered_map<string, char> decMap;
    vector<char> keys;
    vector<string> values;

    Encrypter(vector<char>& keys, vector<string>& values, vector<string>& dictionary) {
        this->keys = keys;
        this->values = values;
        for (int i = 0; i < keys.size(); ++i) {
            encMap[keys[i]] = values[i];
            decMap[values[i]] = keys[i];
        }
        for (const string& word : dictionary) {
            validWords.insert(word);
        }
    }

    string encrypt(string word1) {
        string res = "";
        for (char c : word1) {
            if (encMap.count(c) == 0) return "";
            res += encMap[c];
        }
        return res;
    }

    int decrypt(string word2) {
        int count = 0;
        decryptHelper(word2, 0, "", count);
        return count;
    }

private:
    unordered_set<string> validWords;

    void decryptHelper(const string& word2, int index, string currentWord, int& count) {
        if (index == word2.size()) {
            if (validWords.count(currentWord) > 0) {
                count++;
            }
            return;
        }

        if (index + 1 < word2.size()) {
            string twoChars = word2.substr(index, 2);
            if (decMap.count(twoChars) > 0) {
                decryptHelper(word2, index + 2, currentWord + decMap[twoChars], count);
            }
        }
    }
};