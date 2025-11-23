#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> removeSubfolders(vector<string>& folder) {
        sort(folder.begin(), folder.end());
        vector<string> result;
        result.push_back(folder[0]);

        for (int i = 1; i < folder.size(); ++i) {
            bool isSubfolder = false;
            for (const string& parent : result) {
                if (folder[i].size() > parent.size() &&
                    folder[i].substr(0, parent.size()) == parent &&
                    folder[i][parent.size()] == '/') {
                    isSubfolder = true;
                    break;
                }
            }
            if (!isSubfolder) {
                result.push_back(folder[i]);
            }
        }

        return result;
    }
};