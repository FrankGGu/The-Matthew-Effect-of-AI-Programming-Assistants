#include <string>
#include <vector>
#include <functional> // For std::function if using a destructor for cleanup

struct TrieNode {
    TrieNode* children[26];
    bool isEndOfWord;

    TrieNode() {
        isEndOfWord = false;
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
    }
};

class WordDictionary {
private:
    TrieNode* root;

    bool searchRecursive(TrieNode* node, const std::string& word, int index) {
        if (node == nullptr) {
            return false;
        }

        if (index == word.length()) {
            return node->isEndOfWord;
        }

        char c = word[index];

        if (c == '.') {
            for (int i = 0; i < 26; ++i) {
                if (node->children[i] != nullptr) {
                    if (searchRecursive(node->children[i], word, index + 1)) {
                        return true;
                    }
                }
            }
            return false;
        } else {
            int char_idx = c - 'a';
            if (node->children[char_idx] != nullptr) {
                return searchRecursive(node->children[char_idx], word, index + 1);
            } else {
                return false;
            }
        }
    }

    void deleteTrie(TrieNode* node) {
        if (!node) {
            return;
        }
        for (int i = 0; i < 26; ++i) {
            deleteTrie(node->children[i]);
        }
        delete node;
    }

public:
    WordDictionary() {
        root = new TrieNode();
    }

    ~WordDictionary() {
        deleteTrie(root);
    }

    void addWord(std::string word) {
        TrieNode* current = root;
        for (char c : word) {
            int char_idx = c - 'a';
            if (current->children[char_idx] == nullptr) {
                current->children[char_idx] = new TrieNode();
            }
            current = current->children[char_idx];
        }
        current->isEndOfWord = true;
    }

    bool search(std::string word) {
        return searchRecursive(root, word, 0);
    }
};