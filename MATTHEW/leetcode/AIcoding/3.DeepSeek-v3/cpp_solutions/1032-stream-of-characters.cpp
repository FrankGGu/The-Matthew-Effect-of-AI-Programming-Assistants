class StreamChecker {
private:
    struct TrieNode {
        TrieNode* children[26];
        bool isEnd;
        TrieNode() {
            for (int i = 0; i < 26; ++i) {
                children[i] = nullptr;
            }
            isEnd = false;
        }
    };

    TrieNode* root;
    vector<char> stream;

    void insert(const string& word) {
        TrieNode* node = root;
        for (int i = word.size() - 1; i >= 0; --i) {
            char c = word[i];
            if (!node->children[c - 'a']) {
                node->children[c - 'a'] = new TrieNode();
            }
            node = node->children[c - 'a'];
        }
        node->isEnd = true;
    }

public:
    StreamChecker(vector<string>& words) {
        root = new TrieNode();
        for (const string& word : words) {
            insert(word);
        }
    }

    bool query(char letter) {
        stream.push_back(letter);
        TrieNode* node = root;
        for (int i = stream.size() - 1; i >= 0; --i) {
            char c = stream[i];
            if (!node->children[c - 'a']) {
                return false;
            }
            node = node->children[c - 'a'];
            if (node->isEnd) {
                return true;
            }
        }
        return false;
    }
};