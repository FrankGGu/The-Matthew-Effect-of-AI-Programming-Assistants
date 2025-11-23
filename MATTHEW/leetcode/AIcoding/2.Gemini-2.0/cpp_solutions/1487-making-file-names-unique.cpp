#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> getFolderNames(vector<string>& names) {
        unordered_map<string, int> counts;
        vector<string> result;

        for (string name : names) {
            if (counts.find(name) == counts.end()) {
                result.push_back(name);
                counts[name] = 1;
            } else {
                int k = counts[name];
                string newName = name + "(" + to_string(k) + ")";
                while (counts.find(newName) != counts.end()) {
                    k++;
                    newName = name + "(" + to_string(k) + ")";
                }
                result.push_back(newName);
                counts[name] = k + 1;
                counts[newName] = 1;
            }
        }

        return result;
    }
};