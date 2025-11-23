class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> fileMap;
        for (const string& path : paths) {
            istringstream iss(path);
            string dir;
            iss >> dir;
            string file;
            while (iss >> file) {
                size_t pos = file.find('(');
                string content = file.substr(pos);
                fileMap[content].push_back(dir + "/" + file.substr(0, pos));
            }
        }
        vector<vector<string>> result;
        for (const auto& pair : fileMap) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }
        return result;
    }
};