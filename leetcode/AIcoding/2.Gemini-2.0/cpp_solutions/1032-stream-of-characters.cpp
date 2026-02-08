#include <string>
#include <vector>

using namespace std;

class StreamChecker {
private:
    struct TrieNode {
        TrieNode* children[26];
        bool isWord;
        TrieNode() {
            for (int i = 0; i < 26; ++i) {
                children[i] = nullptr;
            }
            isWord = false;
        }
    };

    TrieNode* root;
    string stream;

    void insert(string word) {
        TrieNode* curr = root;
        for (int i = word.length() - 1; i >= 0; --i) {
            int index = word[i] - 'a';
            if (!curr->children[index]) {
                curr->children[index] = new TrieNode();
            }
            curr = curr->children[index];
        }
        curr->isWord = true;
    }

    bool query(string s) {
        TrieNode* curr = root;
        for (int i = s.length() - 1; i >= 0; --i) {
            int index = s[i] - 'a';
            if (!curr->children[index]) {
                return false;
            }
            curr = curr->children[index];
            if (curr->isWord) {
                return true;
            }
        }
        return false;
    }

public:
    StreamChecker(vector<string>& words) {
        root = new TrieNode();
        for (string word : words) {
            insert(word);
        }
        stream = "";
    }

    bool query(char letter) {
        stream += letter;
        return query(stream);
    }
};