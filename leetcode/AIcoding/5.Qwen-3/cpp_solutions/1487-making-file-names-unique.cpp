#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> getFolderNames(const vector<string>& names) {
        unordered_map<string, int> countMap;
        vector<string> result;

        for (const string& name : names) {
            if (countMap.find(name) == countMap.end()) {
                result.push_back(name);
                countMap[name] = 1;
            } else {
                int cnt = countMap[name];
                string newName = name + "$" + to_string(cnt);
                while (countMap.find(newName) != countMap.end()) {
                    cnt++;
                    newName = name + "$" + to_string(cnt);
                }
                result.push_back(newName);
                countMap[name] = cnt + 1;
                countMap[newName] = 1;
            }
        }

        return result;
    }
};