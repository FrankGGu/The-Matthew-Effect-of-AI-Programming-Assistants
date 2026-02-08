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

    void insert(const string& word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->isEnd = true;
    }

    bool search(const string& word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                return false;
            }
            node = node->children[c];
        }
        return node->isEnd;
    }

public:
    Solution() {
        root = new TrieNode();
    }

    ~Solution() {
                vector<TrieNode*> nodes;
        nodes.push_back(root);
        for (int i = 0; i < nodes.size(); ++i) {
            for (auto& pair : nodes[i]->children) {
                nodes.push_back(pair.second);
            }
        }
        for (auto node : nodes) {
            delete node;
        }
    }

    void insertWord(const string& word) {
        insert(word);
    }

    bool query(char c) {
        static string buffer;
        buffer += c;
        int len = buffer.length();
        for (int i = 1; i <= len; ++i) {
            string sub = buffer.substr(len - i, i);
            if (search(sub)) {
                return true;
            }
        }
        return false;
    }
};