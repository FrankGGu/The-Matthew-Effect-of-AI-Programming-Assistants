#include <string>
#include <vector>
#include <sstream>

struct TrieNode {
    TrieNode* children[26];
    bool isWord;

    TrieNode() : isWord(false) {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
    }
};

class Trie {
public:
    TrieNode* root;

    Trie() {
        root = new TrieNode();
    }

    void insert(const std::string& word) {
        TrieNode* curr = root;
        for (char c : word) {
            int idx = c - 'a';
            if (curr->children[idx] == nullptr) {
                curr->children[idx] = new TrieNode();
            }
            curr = curr->children[idx];
        }
        curr->isWord = true;
    }

    std::string findShortestRoot(const std::string& word) {
        TrieNode* curr = root;
        std::string prefix = "";
        for (char c : word) {
            int idx = c - 'a';
            if (curr->children[idx] == nullptr) {
                return "";
            }
            curr = curr->children[idx];
            prefix += c;
            if (curr->isWord) {
                return prefix;
            }
        }
        return "";
    }
};

class Solution {
public:
    std::string replaceWords(std::vector<std::string>& dictionary, std::string sentence) {
        Trie trie;
        for (const std::string& root : dictionary) {
            trie.insert(root);
        }

        std::stringstream ss(sentence);
        std::string word;
        std::vector<std::string> processedWords;

        while (ss >> word) {
            std::string shortestRoot = trie.findShortestRoot(word);
            if (!shortestRoot.empty()) {
                processedWords.push_back(shortestRoot);
            } else {
                processedWords.push_back(word);
            }
        }

        std::string result = "";
        if (!processedWords.empty()) {
            result += processedWords[0];
            for (size_t i = 1; i < processedWords.size(); ++i) {
                result += " ";
                result += processedWords[i];
            }
        }

        return result;
    }
};