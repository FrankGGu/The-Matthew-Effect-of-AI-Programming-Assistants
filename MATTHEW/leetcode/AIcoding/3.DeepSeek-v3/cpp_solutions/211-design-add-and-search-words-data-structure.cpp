class TrieNode {
public:
    TrieNode* children[26];
    bool isEnd;
    TrieNode() {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
        isEnd = false;
    }
};

class WordDictionary {
private:
    TrieNode* root;
public:
    WordDictionary() {
        root = new TrieNode();
    }

    void addWord(string word) {
        TrieNode* node = root;
        for (char c : word) {
            int idx = c - 'a';
            if (!node->children[idx]) {
                node->children[idx] = new TrieNode();
            }
            node = node->children[idx];
        }
        node->isEnd = true;
    }

    bool search(string word) {
        return searchHelper(word, 0, root);
    }

    bool searchHelper(string& word, int idx, TrieNode* node) {
        if (idx == word.size()) {
            return node->isEnd;
        }
        char c = word[idx];
        if (c == '.') {
            for (int i = 0; i < 26; ++i) {
                if (node->children[i] && searchHelper(word, idx + 1, node->children[i])) {
                    return true;
                }
            }
            return false;
        } else {
            int childIdx = c - 'a';
            if (!node->children[childIdx]) {
                return false;
            }
            return searchHelper(word, idx + 1, node->children[childIdx]);
        }
    }
};