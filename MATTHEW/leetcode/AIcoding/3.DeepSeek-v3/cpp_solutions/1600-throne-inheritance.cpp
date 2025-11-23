class ThroneInheritance {
private:
    unordered_map<string, vector<string>> family;
    unordered_set<string> dead;
    string king;

public:
    ThroneInheritance(string kingName) : king(kingName) {}

    void birth(string parentName, string childName) {
        family[parentName].push_back(childName);
    }

    void death(string name) {
        dead.insert(name);
    }

    vector<string> getInheritanceOrder() {
        vector<string> order;
        dfs(king, order);
        return order;
    }

private:
    void dfs(const string& name, vector<string>& order) {
        if (dead.find(name) == dead.end()) {
            order.push_back(name);
        }
        for (const string& child : family[name]) {
            dfs(child, order);
        }
    }
};