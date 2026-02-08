#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <memory>

using namespace std;

class Solution {
public:
    vector<string> deleteDuplicateFolders(vector<string>& paths) {
        struct TrieNode {
            unordered_map<string, unique_ptr<TrieNode>> children;
            bool isEnd = false;
        };

        auto root = make_unique<TrieNode>();

        for (const auto& path : paths) {
            auto node = root.get();
            for (const auto& dir : split(path, '/')) {
                if (!node->children.count(dir)) {
                    node->children[dir] = make_unique<TrieNode>();
                }
                node = node->children[dir].get();
            }
            node->isEnd = true;
        }

        unordered_map<string, vector<string>> subtreeMap;
        vector<string> result;

        function<void(TrieNode*, string)> dfs = [&](TrieNode* node, string currentPath) {
            string key = "";
            for (const auto& [dir, child] : node->children) {
                dfs(child.get(), currentPath + "/" + dir);
                key += dir + ":" + child->isEnd ? "1" : "0";
            }
            subtreeMap[key].push_back(currentPath);
        };

        dfs(root.get(), "");

        for (const auto& [key, paths] : subtreeMap) {
            if (paths.size() > 1) {
                for (const auto& path : paths) {
                    result.push_back(path);
                }
            }
        }

        return result;
    }

private:
    vector<string> split(const string& s, char delimiter) {
        vector<string> tokens;
        string token;
        for (char c : s) {
            if (c == delimiter) {
                if (!token.empty()) {
                    tokens.push_back(token);
                    token.clear();
                }
            } else {
                token += c;
            }
        }
        if (!token.empty()) {
            tokens.push_back(token);
        }
        return tokens;
    }
};