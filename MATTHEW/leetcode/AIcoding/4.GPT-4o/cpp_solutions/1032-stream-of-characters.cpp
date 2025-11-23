#include <unordered_set>
#include <string>
#include <vector>

class StreamChecker {
public:
    StreamChecker(std::vector<std::string>& words) {
        for (const auto& word : words) {
            trie.insert(word);
        }
    }

    bool query(char letter) {
        stream.push_back(letter);
        return trie.search(stream);
    }

private:
    class TrieNode {
    public:
        std::unordered_map<char, TrieNode*> children;
        bool isEndOfWord = false;
    };

    class Trie {
    public:
        TrieNode* root;

        Trie() {
            root = new TrieNode();
        }

        void insert(const std::string& word) {
            TrieNode* node = root;
            for (char c : word) {
                if (!node->children.count(c)) {
                    node->children[c] = new TrieNode();
                }
                node = node->children[c];
            }
            node->isEndOfWord = true;
        }

        bool search(const std::vector<char>& stream) {
            TrieNode* node = root;
            for (int i = stream.size() - 1; i >= 0; i--) {
                if (!node->children.count(stream[i])) return false;
                node = node->children[stream[i]];
                if (node->isEndOfWord) return true;
            }
            return false;
        }
    };

    Trie trie;
    std::vector<char> stream;
};