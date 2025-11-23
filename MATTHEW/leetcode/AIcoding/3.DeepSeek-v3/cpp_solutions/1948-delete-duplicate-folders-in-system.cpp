struct TrieNode {
    unordered_map<string, TrieNode*> children;
    string key;
    bool isDeleted = false;

    TrieNode(string key = "") : key(key) {}
};

class Solution {
public:
    vector<vector<string>> deleteDuplicateFolder(vector<vector<string>>& paths) {
        TrieNode* root = new TrieNode();
        for (auto& path : paths) {
            insert(root, path);
        }

        unordered_map<string, TrieNode*> seen;
        dedup(root, seen);

        vector<vector<string>> result;
        vector<string> currentPath;
        getPaths(root, currentPath, result);

        return result;
    }

private:
    void insert(TrieNode* root, vector<string>& path) {
        TrieNode* node = root;
        for (auto& folder : path) {
            if (node->children.find(folder) == node->children.end()) {
                node->children[folder] = new TrieNode(folder);
            }
            node = node->children[folder];
        }
    }

    string dedup(TrieNode* node, unordered_map<string, TrieNode*>& seen) {
        string subfolder;
        for (auto& [folder, child] : node->children) {
            subfolder += dedup(child, seen);
        }

        if (!subfolder.empty()) {
            if (seen.find(subfolder) != seen.end()) {
                seen[subfolder]->isDeleted = true;
                node->isDeleted = true;
            } else {
                seen[subfolder] = node;
            }
        }

        return "(" + node->key + subfolder + ")";
    }

    void getPaths(TrieNode* node, vector<string>& currentPath, vector<vector<string>>& result) {
        for (auto& [folder, child] : node->children) {
            if (!child->isDeleted) {
                currentPath.push_back(folder);
                result.push_back(currentPath);
                getPaths(child, currentPath, result);
                currentPath.pop_back();
            }
        }
    }
};