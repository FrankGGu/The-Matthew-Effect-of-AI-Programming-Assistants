#include <vector>
#include <string>

class Solution {
public:
    struct TrieNode {
        TrieNode* children[26];
        int count; 

        TrieNode() {
            for (int i = 0; i < 26; ++i) {
                children[i] = nullptr;
            }
            count = 0;
        }
    };

    void insert(TrieNode* root, const std::string& word) {
        TrieNode* curr = root;
        for (char c : word) {
            int index = c - 'a';
            if (curr->children[index] == nullptr) {
                curr->children[index] = new TrieNode();
            }
            curr = curr->children[index];
            curr->count++; 
        }
    }

    long long getScore(TrieNode* root, const std::string& word) {
        long long score = 0;
        TrieNode* curr = root;
        for (char c : word) {
            int index = c - 'a';
            curr = curr->children[index]; 
            score += curr->count;
        }
        return score;
    }

    std::vector<long long> sumPrefixScores(std::vector<std::string>& words) {
        TrieNode* root = new TrieNode();

        for (const std::string& word : words) {
            insert(root, word);
        }

        std::vector<long long> result;
        for (const std::string& word : words) {
            result.push_back(getScore(root, word));
        }

        // Memory cleanup for Trie (optional for LeetCode, but good practice)
        // std::function<void(TrieNode*)> deleteTrie = 
        //     [&](TrieNode* node) {
        //     if (!node) return;
        //     for (int i = 0; i < 26; ++i) {
        //         deleteTrie(node->children[i]);
        //     }
        //     delete node;
        // };
        // deleteTrie(root);

        return result;
    }
};