#include <string>
#include <vector>
#include <map>

class MapSum {
private:
    struct TrieNode {
        TrieNode* children[26];
        long long val_sum; 

        TrieNode() : val_sum(0) {
            for (int i = 0; i < 26; ++i) {
                children[i] = nullptr;
            }
        }
    };

    TrieNode* root;
    std::map<std::string, int> key_to_val;

    void deleteTrie(TrieNode* node) {
        if (!node) return;
        for (int i = 0; i < 26; ++i) {
            deleteTrie(node->children[i]);
        }
        delete node;
    }

public:
    MapSum() {
        root = new TrieNode();
    }

    ~MapSum() {
        deleteTrie(root);
    }

    void insert(std::string key, int val) {
        int delta = val;
        if (key_to_val.count(key)) {
            delta = val - key_to_val[key];
        }
        key_to_val[key] = val;

        TrieNode* curr = root;
        for (char c : key) {
            int idx = c - 'a';
            if (curr->children[idx] == nullptr) {
                curr->children[idx] = new TrieNode();
            }
            curr = curr->children[idx];
            curr->val_sum += delta;
        }
    }

    int sum(std::string prefix) {
        TrieNode* curr = root;
        for (char c : prefix) {
            int idx = c - 'a';
            if (curr->children[idx] == nullptr) {
                return 0;
            }
            curr = curr->children[idx];
        }
        return static_cast<int>(curr->val_sum);
    }
};