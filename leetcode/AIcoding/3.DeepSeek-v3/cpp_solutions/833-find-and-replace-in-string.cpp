class Solution {
public:
    string findReplaceString(string s, vector<int>& indices, vector<string>& sources, vector<string>& targets) {
        vector<pair<int, string>> ops;
        for (int i = 0; i < indices.size(); ++i) {
            ops.emplace_back(indices[i], to_string(i));
        }
        sort(ops.rbegin(), ops.rend());
        for (auto& op : ops) {
            int i = op.first;
            string idx = op.second;
            int j = stoi(idx);
            string source = sources[j];
            if (s.substr(i, source.size()) == source) {
                s.replace(i, source.size(), targets[j]);
            }
        }
        return s;
    }
};