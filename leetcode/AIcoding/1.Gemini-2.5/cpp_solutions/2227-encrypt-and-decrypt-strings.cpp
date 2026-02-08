#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Encrypter {
private:
    unordered_map<char, string> key_to_val;
    unordered_map<string, int> encrypted_counts;

public:
    Encrypter(vector<char>& keys, vector<string>& values, vector<string>& dictionary) {
        for (size_t i = 0; i < keys.size(); ++i) {
            key_to_val[keys[i]] = values[i];
        }

        for (const string& word : dictionary) {
            string encrypted_word = encrypt(word);
            encrypted_counts[encrypted_word]++;
        }
    }

    string encrypt(string word1) {
        string result;
        result.reserve(word1.length() * 2);
        for (char c : word1) {
            result += key_to_val[c];
        }
        return result;
    }

    int decrypt(string word2) {
        auto it = encrypted_counts.find(word2);
        if (it != encrypted_counts.end()) {
            return it->second;
        }
        return 0;
    }
};