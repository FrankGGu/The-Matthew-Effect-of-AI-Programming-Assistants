class TrieNode {
public:
    unordered_map<char, TrieNode*> children;
    bool isEndOfWord;

    TrieNode() : isEndOfWord(false) {}
};

class WordDictionary {
private:
    TrieNode* root;

    bool searchInNode(const string& word, TrieNode* node, int index) {
        if (index == word.size()) {
            return node->isEndOfWord;
        }
        char c = word[index];
        if (c == '.') {
            for (auto& pair : node->children) {
                if (searchInNode(word, pair.second, index + 1)) {
                    return true;
                }
            }
            return false;
        } else {
            if (node->children.count(c) == 0) {
                return false;
            }
            return searchInNode(word, node->children[c], index + 1);
        }
    }

public:
    WordDictionary() {
        root = new TrieNode();
    }

    void addWord(const string& word) {
        TrieNode* node = root;
        for (char c : word) {
            if (node->children.count(c) == 0) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->isEndOfWord = true;
    }

    bool search(const string& word) {
        return searchInNode(word, root, 0);
    }
};