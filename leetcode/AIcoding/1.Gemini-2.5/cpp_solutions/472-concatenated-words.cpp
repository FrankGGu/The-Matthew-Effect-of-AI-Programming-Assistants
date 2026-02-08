#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

class Solution {
private:
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

    TrieNode* root;

    void insert(const std::string& word) {
        TrieNode* curr = root;
        for (char c : word) {
            int index = c - 'a';
            if (!curr->children[index]) {
                curr->children[index] = new TrieNode();
            }
            curr = curr->children[index];
        }
        curr->isEndOfWord = true;
    }

    bool canForm(const std::string& word) {
        if (word.empty()) {
            return false;
        }
        int n = word.length();
        std::vector<bool> dp(n + 1, false);
        dp[0] = true;

        for (int i = 0; i < n; ++i) {
            if (!dp[i]) {
                continue;
            }

            TrieNode* curr = root;
            for (int j = i; j < n; ++j) {
                int index = word[j] - 'a';
                if (!curr->children[index]) {
                    break;
                }
                curr = curr->children[index];
                if (curr->isEndOfWord) {
                    if (j + 1 <= n) {
                        dp[j + 1] = true;
                    }
                }
            }
        }
        return dp[n];
    }

public:
    std::vector<std::string> findAllConcatenatedWordsInADict(std::vector<std::string>& words) {
        root = new TrieNode();
        std::sort(words.begin(), words.end(), [](const std::string& a, const std::string& b) {
            return a.length() < b.length();
        });

        std::vector<std::string> result;
        for (const std::string& word : words) {
            if (word.empty()) {
                continue;
            }
            if (canForm(word)) {
                result.push_back(word);
            }
            insert(word);
        }

        // Basic memory cleanup, though not strictly required by LeetCode environment
        // A full recursive deletion would be better for a production system.
        // delete root; 

        return result;
    }
};