class MapSum {
private:
    struct TrieNode {
        int val;
        unordered_map<char, TrieNode*> children;
        TrieNode() : val(0) {}
    };
    TrieNode* root;
    unordered_map<string, int> key_val;

public:
    MapSum() {
        root = new TrieNode();
    }

    void insert(string key, int val) {
        int delta = val - key_val[key];
        key_val[key] = val;
        TrieNode* node = root;
        for (char c : key) {
            if (node->children.find(c) == node->children.end()) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
            node->val += delta;
        }
    }

    int sum(string prefix) {
        TrieNode* node = root;
        for (char c : prefix) {
            if (node->children.find(c) == node->children.end()) {
                return 0;
            }
            node = node->children[c];
        }
        return node->val;
    }
};