#include <string>
#include <vector>
#include <map>

class TrieNode {
public:
    TrieNode* children[26];
    int prefix_sum;

    TrieNode() : prefix_sum(0) {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
    }

    ~TrieNode() {
        for (int i = 0; i < 26; ++i) {
            delete children[i];
        }
    }
};

class MapSum {
private:
    TrieNode* root;
    std::map<std::string, int> key_to_val;

public:
    MapSum() {
        root = new TrieNode();
    }

    ~MapSum() {
        delete root;
    }

    void insert(std::string key, int val) {
        int old_val = 0;
        if (key_to_val.count(key)) {
            old_val = key_to_val[key];
        }

        int delta = val - old_val;
        key_to_val[key] = val;

        TrieNode* curr = root;
        for (char c : key) {
            int idx = c - 'a';
            if (curr->children[idx] == nullptr) {
                curr->children[idx] = new TrieNode();
            }
            curr = curr->children[idx];
            curr->prefix_sum += delta;
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
        return curr->prefix_sum;
    }
};