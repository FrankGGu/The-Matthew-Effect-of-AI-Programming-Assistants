class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> contentToFiles;
        for (const string& path : paths) {
            istringstream iss(path);
            string dir;
            string file;
            getline(iss, dir, ' ');
            while (getline(iss, file, ' ')) {
                size_t pos = file.find('(');
                string fileName = file.substr(0, pos);
                string content = file.substr(pos + 1, file.size() - pos - 2);
                contentToFiles[content].push_back(dir + "/" + fileName);
            }
        }
        vector<vector<string>> result;
        for (const auto& pair : contentToFiles) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }
        return result;
    }
};