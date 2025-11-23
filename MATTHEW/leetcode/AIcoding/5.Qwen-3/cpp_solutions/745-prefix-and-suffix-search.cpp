#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    struct TrieNode {
        unordered_map<char, TrieNode*> children;
        int index;
    };

    TrieNode* root;

    Solution() {
        root = new TrieNode();
    }

    void insert(string word, int index) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->index = index;
    }

    int search(string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                return -1;
            }
            node = node->children[c];
        }
        return node->index;
    }

    vector<int> prefixSuffixSearch(vector<string>& words, vector<vector<string>>& queries) {
        vector<int> result;
        for (int i = 0; i < words.size(); ++i) {
            string word = words[i];
            insert(word, i);
        }

        for (auto& query : queries) {
            string prefix = query[0];
            string suffix = query[1];
            string combined = suffix + "#" + prefix;
            result.push_back(search(combined));
        }

        return result;
    }
};