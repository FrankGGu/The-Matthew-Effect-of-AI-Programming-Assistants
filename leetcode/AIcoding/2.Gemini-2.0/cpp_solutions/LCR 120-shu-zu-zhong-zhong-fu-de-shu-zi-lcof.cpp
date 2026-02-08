#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> contentToFiles;
        vector<vector<string>> result;

        for (const string& path : paths) {
            string dir;
            vector<string> files;
            string current;
            bool inDir = true;

            for (char c : path) {
                if (c == ' ') {
                    if (inDir) {
                        dir = current;
                        inDir = false;
                    } else {
                        files.push_back(current);
                    }
                    current = "";
                } else {
                    current += c;
                }
            }
            files.push_back(current); 

            for (const string& file : files) {
                string filename;
                string content;
                bool inFilename = true;

                for (char c : file) {
                    if (c == '(') {
                        inFilename = false;
                    } else if (c == ')') {
                        continue;
                    } else if (inFilename) {
                        filename += c;
                    } else {
                        content += c;
                    }
                }

                contentToFiles[content].push_back(dir + "/" + filename);
            }
        }

        for (const auto& pair : contentToFiles) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }

        return result;
    }
};