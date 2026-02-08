#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> contentMap;

        for (const string& path : paths) {
            size_t pos = 0;
            string fileName;
            string fileContent;
            bool inContent = false;

            for (char c : path) {
                if (c == '(') {
                    inContent = true;
                } else if (c == ')') {
                    inContent = false;
                    contentMap[fileContent].push_back(fileName);
                    fileContent.clear();
                } else if (inContent) {
                    fileContent += c;
                } else if (c == ' ') {
                    fileName = path.substr(pos, path.find('(', pos) - pos);
                    pos = path.find('(', pos) + 1;
                }
            }
        }

        vector<vector<string>> result;
        for (auto& pair : contentMap) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }

        return result;
    }
};