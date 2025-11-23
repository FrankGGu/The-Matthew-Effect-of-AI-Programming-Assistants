class Solution {
private:
    class TrieNode {
    public:
        bool isWord;
        TrieNode* children[26];
        TrieNode() {
            isWord = false;
            for (int i = 0; i < 26; i++) {
                children[i] = nullptr;
            }
        }
    };
    class Trie {
    private:
        TrieNode* root;
    public:
        Trie() {
            root = new TrieNode();
        }
        void insert(string word) {
            TrieNode* node = root;
            for (char c : word) {
                int idx = c - 'a';
                if (node->children[idx] == nullptr) {
                    node->children[idx] = new TrieNode();
                }
                node = node->children[idx];
            }
            node->isWord = true;
        }
        string searchRoot(string word) {
            TrieNode* node = root;
            string prefix = "";
            for (char c : word) {
                int idx = c - 'a';
                if (node->children[idx] == nullptr) {
                    return word;
                }
                prefix += c;
                node = node->children[idx];
                if (node->isWord) {
                    return prefix;
                }
            }
            return word;
        }
    };
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        Trie trie;
        for (string root : dictionary) {
            trie.insert(root);
        }
        stringstream ss(sentence);
        string word;
        string result = "";
        while (ss >> word) {
            if (!result.empty()) {
                result += " ";
            }
            result += trie.searchRoot(word);
        }
        return result;
    }
};