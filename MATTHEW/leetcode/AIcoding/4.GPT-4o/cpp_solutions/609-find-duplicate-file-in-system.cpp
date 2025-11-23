class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> contentMap;
        for (const string& path : paths) {
            istringstream iss(path);
            string dir;
            iss >> dir;
            string file;
            while (iss >> file) {
                size_t pos = file.find('(');
                string filename = file.substr(0, pos);
                string content = file.substr(pos + 1, file.size() - pos - 2);
                contentMap[content].push_back(dir + "/" + filename);
            }
        }
        vector<vector<string>> result;
        for (const auto& entry : contentMap) {
            if (entry.second.size() > 1) {
                result.push_back(entry.second);
            }
        }
        return result;
    }
};