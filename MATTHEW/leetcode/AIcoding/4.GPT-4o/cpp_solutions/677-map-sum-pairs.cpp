class MapSum {
public:

    MapSum() {
        root = new TrieNode();
    }

    void insert(string key, int val) {
        int delta = val;
        if (m.count(key)) {
            delta -= m[key];
        }
        m[key] = val;
        TrieNode* node = root;
        for (char c : key) {
            if (!node->children[c - 'a']) {
                node->children[c - 'a'] = new TrieNode();
            }
            node = node->children[c - 'a'];
            node->sum += delta;
        }
    }

    int sum(string prefix) {
        TrieNode* node = root;
        for (char c : prefix) {
            if (!node->children[c - 'a']) {
                return 0;
            }
            node = node->children[c - 'a'];
        }
        return node->sum;
    }

private:
    struct TrieNode {
        TrieNode* children[26] = {};
        int sum = 0;
    };

    TrieNode* root;
    unordered_map<string, int> m;
};