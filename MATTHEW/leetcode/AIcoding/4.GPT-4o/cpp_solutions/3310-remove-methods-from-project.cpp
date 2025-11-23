class Solution {
public:
    vector<string> removeMethods(vector<string>& methods) {
        unordered_set<string> seen;
        vector<string> result;

        for (const string& method : methods) {
            size_t pos = method.find('(');
            string name = method.substr(0, pos);
            if (seen.find(name) == seen.end()) {
                seen.insert(name);
                result.push_back(method);
            }
        }

        return result;
    }
};