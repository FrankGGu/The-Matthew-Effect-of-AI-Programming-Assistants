#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <unordered_map>
#include <vector>

using namespace std;

vector<vector<string>> findDuplicate(vector<string>& paths) {
    unordered_map<string, vector<string>> content_map;
    for (const string& path : paths) {
        istringstream iss(path);
        string dir;
        iss >> dir;
        string file;
        while (iss >> file) {
            size_t pos = file.find('(');
            string file_name = file.substr(0, pos);
            string content = file.substr(pos + 1, file.size() - pos - 2);
            content_map[content].push_back(dir + "/" + file_name);
        }
    }
    vector<vector<string>> result;
    for (const auto& entry : content_map) {
        if (entry.second.size() > 1) {
            result.push_back(entry.second);
        }
    }
    return result;
}