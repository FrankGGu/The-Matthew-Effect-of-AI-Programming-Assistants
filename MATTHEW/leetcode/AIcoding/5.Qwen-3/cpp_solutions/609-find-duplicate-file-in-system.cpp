#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<string>> findDuplicate(vector<string>& paths) {
        unordered_map<string, vector<string>> hash;
        for (const string& path : paths) {
            size_t pos = 0;
            string dir = "";
            while (pos < path.size() && path[pos] != ' ') {
                dir += path[pos++];
                ++pos;
            }
            while (pos < path.size()) {
                size_t start = pos;
                while (pos < path.size() && path[pos] != '(') ++pos;
                string filename = path.substr(start, pos - start);
                ++pos;
                start = pos;
                while (pos < path.size() && path[pos] != ')') ++pos;
                string content = path.substr(start, pos - start);
                ++pos;
                hash[content].push_back(dir + "/" + filename);
            }
        }
        vector<vector<string>> result;
        for (auto& pair : hash) {
            if (pair.second.size() > 1) {
                result.push_back(pair.second);
            }
        }
        return result;
    }
};