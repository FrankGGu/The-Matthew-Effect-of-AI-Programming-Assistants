#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> removeSubfolders(vector<string>& folders) {
        sort(folders.begin(), folders.end());
        vector<string> result;
        string prev = "";
        for (const string& folder : folders) {
            if (prev.empty() || folder.find(prev) != 0 || folder[prev.size()] != '/') {
                result.push_back(folder);
                prev = folder;
            }
        }
        return result;
    }
};