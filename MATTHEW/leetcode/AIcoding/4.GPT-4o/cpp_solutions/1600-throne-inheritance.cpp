class TreeNode {
public:
    string name;
    vector<TreeNode*> children;

    TreeNode(string n) : name(n) {}
};

class ThroneInheritance {
public:
    TreeNode* root;
    unordered_set<string> dead;

    ThroneInheritance(string kingName) {
        root = new TreeNode(kingName);
    }

    void birth(string parentName, string childName) {
        TreeNode* parent = findNode(root, parentName);
        if (parent) {
            parent->children.push_back(new TreeNode(childName));
        }
    }

    void death(string name) {
        dead.insert(name);
    }

    vector<string> getInheritanceOrder() {
        vector<string> order;
        dfs(root, order);
        return order;
    }

private:
    TreeNode* findNode(TreeNode* node, const string& name) {
        if (node->name == name) return node;
        for (TreeNode* child : node->children) {
            TreeNode* found = findNode(child, name);
            if (found) return found;
        }
        return nullptr;
    }

    void dfs(TreeNode* node, vector<string>& order) {
        if (dead.find(node->name) == dead.end()) {
            order.push_back(node->name);
        }
        for (TreeNode* child : node->children) {
            dfs(child, order);
        }
    }
};