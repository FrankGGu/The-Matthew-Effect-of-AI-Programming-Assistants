class TrieNode {
public:
    unordered_map<string, TrieNode*> children;
    string value;
    bool isEnd;

    TrieNode() : isEnd(false) {}
};

class Router {
private:
    TrieNode* root;

    vector<string> splitPath(const string& path) {
        vector<string> parts;
        stringstream ss(path.substr(1));
        string part;
        while (getline(ss, part, '/')) {
            if (!part.empty()) {
                parts.push_back(part);
            }
        }
        return parts;
    }

public:
    Router() {
        root = new TrieNode();
    }

    void addRoute(string path, string value) {
        vector<string> parts = splitPath(path);
        TrieNode* node = root;
        for (const string& part : parts) {
            if (node->children.find(part) == node->children.end()) {
                node->children[part] = new TrieNode();
            }
            node = node->children[part];
        }
        node->isEnd = true;
        node->value = value;
    }

    string lookup(string path) {
        vector<string> parts = splitPath(path);
        TrieNode* node = root;
        for (const string& part : parts) {
            if (node->children.find(part) != node->children.end()) {
                node = node->children[part];
            } else {
                return "";
            }
        }
        return node->isEnd ? node->value : "";
    }
};