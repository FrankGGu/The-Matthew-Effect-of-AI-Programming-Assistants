#include <vector>
#include <string>
#include <deque>
#include <memory>
#include <algorithm>

struct TrieNode {
    std::unique_ptr<TrieNode> children[26];
    bool isEndOfWord;

    TrieNode() : isEndOfWord(false) {
    }
};

class StreamChecker {
private:
    std::unique_ptr<TrieNode> root;
    std::deque<char> stream;
    int maxWordLength; 

    void insert(const std::string& word) {
        TrieNode* curr = root.get();
        for (char c : word) {
            int idx = c - 'a';
            if (!curr->children[idx]) {
                curr->children[idx] = std::make_unique<TrieNode>();
            }
            curr = curr->children[idx].get();
        }
        curr->isEndOfWord = true;
    }

public:
    StreamChecker(std::vector<std::string>& words) : root(std::make_unique<TrieNode>()), maxWordLength(0) {
        for (const std::string& word : words) {
            std::string reversedWord = word;
            std::reverse(reversedWord.begin(), reversedWord.end());
            insert(reversedWord);
            if (word.length() > maxWordLength) {
                maxWordLength = word.length();
            }
        }
    }

    bool query(char letter) {
        stream.push_back(letter);

        if (stream.size() > maxWordLength) {
            stream.pop_front();
        }

        TrieNode* curr = root.get();
        for (int i = stream.size() - 1; i >= 0; --i) {
            char c = stream[i];
            int idx = c - 'a';

            if (!curr->children[idx]) {
                return false; 
            }
            curr = curr->children[idx].get();

            if (curr->isEndOfWord) {
                return true; 
            }
        }

        return false; 
    }
};