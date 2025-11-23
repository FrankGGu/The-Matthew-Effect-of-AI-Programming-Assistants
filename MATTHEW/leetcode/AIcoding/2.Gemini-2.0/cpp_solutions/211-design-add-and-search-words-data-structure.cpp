class WordDictionary {
private:
    struct TrieNode {
        TrieNode* children[26];
        bool isWord;
        TrieNode() {
            for (int i = 0; i < 26; ++i) {
                children[i] = nullptr;
            }
            isWord = false;
        }
    };

    TrieNode* root;

public:
    WordDictionary() {
        root = new TrieNode();
    }

    void addWord(string word) {
        TrieNode* curr = root;
        for (char c : word) {
            int index = c - 'a';
            if (!curr->children[index]) {
                curr->children[index] = new TrieNode();
            }
            curr = curr->children[index];
        }
        curr->isWord = true;
    }

    bool search(string word) {
        return searchHelper(word, 0, root);
    }

private:
    bool searchHelper(string word, int index, TrieNode* node) {
        if (!node) {
            return false;
        }
        if (index == word.length()) {
            return node->isWord;
        }

        char c = word[index];
        if (c == '.') {
            for (int i = 0; i < 26; ++i) {
                if (searchHelper(word, index + 1, node->children[i])) {
                    return true;
                }
            }
            return false;
        } else {
            int charIndex = c - 'a';
            if (node->children[charIndex]) {
                return searchHelper(word, index + 1, node->children[charIndex]);
            } else {
                return false;
            }
        }
    }
};