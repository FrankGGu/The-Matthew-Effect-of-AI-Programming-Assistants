class TrieNode {
public:
    unordered_map<char, TrieNode*> children;
    int val;
    TrieNode() : val(0) {}
};

class MapSum {
private:
    TrieNode* root;
    unordered_map<string, int> keys;

public:
    MapSum() {
        root = new TrieNode();
    }

    void insert(string key, int val) {
        int delta = val - keys[key];
        TrieNode* node = root;
        for (char c : key) {
            if (node->children.find(c) == node->children.end()) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
            node->val += delta;
        }
        keys[key] = val;
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