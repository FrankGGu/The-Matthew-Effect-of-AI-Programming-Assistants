#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

vector<string> removeSubfolders(vector<string>& folder) {
    unordered_set<string> folderSet(folder.begin(), folder.end());
    vector<string> result;

    for (const string& f : folder) {
        bool isSubfolder = false;
        for (int i = 1; i < f.size(); ++i) {
            if (f[i] == '/') {
                string parent = f.substr(0, i);
                if (folderSet.count(parent)) {
                    isSubfolder = true;
                    break;
                }
            }
        }
        if (!isSubfolder) {
            result.push_back(f);
        }
    }
    return result;
}