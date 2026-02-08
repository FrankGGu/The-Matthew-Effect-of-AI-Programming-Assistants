class Trie {
private:
    Trie* children[26];
    bool isEndOfWord;

public:
    Trie() {
        for (int i = 0; i < 26; i++) {
            children[i] = nullptr;
        }
        isEndOfWord = false;
    }

    void insert(string word) {
        Trie* node = this;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                node->children[index] = new Trie();
            }
            node = node->children[index];
        }
        node->isEndOfWord = true;
    }

    bool search(string word) {
        Trie* node = this;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                return false;
            }
            node = node->children[index];
        }
        return node->isEndOfWord;
    }

    bool startsWith(string prefix) {
        Trie* node = this;
        for (char c : prefix) {
            int index = c - 'a';
            if (!node->children[index]) {
                return false;
            }
            node = node->children[index];
        }
        return true;
    }
};