#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> deleteDuplicateFolder(vector<string>& paths) {
        unordered_map<string, vector<string>> tree;
        unordered_set<string> duplicates;

        for (const string& path : paths) {
            string folder = "";
            size_t pos = 0;
            while ((pos = path.find('/', pos)) != string::npos) {
                string current = path.substr(0, pos);
                tree[current].push_back(path);
                pos++;
            }
            tree[path].push_back(path);
        }

        function<string(string)> collect = [&](string node) {
            vector<string> subFolders;
            for (const auto& child : tree[node]) {
                string folder = collect(child);
                if (!folder.empty()) {
                    subFolders.push_back(folder);
                }
            }
            sort(subFolders.begin(), subFolders.end());
            string serialized = "(" + join(subFolders) + ")";
            if (duplicates.count(serialized)) {
                return "";
            }
            duplicates.insert(serialized);
            return node;
        };

        collect("");

        vector<string> result;
        for (const auto& path : paths) {
            if (duplicates.count(path) == 0) {
                result.push_back(path);
            }
        }
        return result;
    }

private:
    string join(const vector<string>& folders) {
        string result;
        for (const auto& folder : folders) {
            result += folder + "/";
        }
        return result.empty() ? "" : result.substr(0, result.size() - 1);
    }
};