#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> contentToPaths;
        for (const string& path : paths) {
            stringstream ss(path);
            string directory;
            getline(ss, directory, ' ');
            string fileInfo;
            while (getline(ss, fileInfo, ' ')) {
                size_t openParen = fileInfo.find('(');
                string fileName = fileInfo.substr(0, openParen);
                string content = fileInfo.substr(openParen + 1, fileInfo.length() - openParen - 2);
                contentToPaths[content].push_back(directory + "/" + fileName);
            }
        }

        vector<vector<string>> result;
        for (const auto& pair : contentToPaths) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }

        return result;
    }
};