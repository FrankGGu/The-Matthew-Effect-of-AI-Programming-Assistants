#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
private:
    struct TrieNode {
        unordered_map<char, TrieNode*> children;
        bool isEnd;
    };

    TrieNode* root;

public:
    Solution() {
        root = new TrieNode();
    }

    void addWord(string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->isEnd = true;
    }

    bool search(string word) {
        return searchHelper(word, 0, root);
    }

    bool searchHelper(string& word, int index, TrieNode* node) {
        if (index == word.size()) {
            return node->isEnd;
        }

        char c = word[index];
        if (c == '.') {
            for (auto& pair : node->children) {
                if (searchHelper(word, index + 1, pair.second)) {
                    return true;
                }
            }
            return false;
        } else {
            if (!node->children[c]) {
                return false;
            }
            return searchHelper(word, index + 1, node->children[c]);
        }
    }
};