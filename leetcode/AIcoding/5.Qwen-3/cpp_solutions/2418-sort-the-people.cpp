#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> sortPeople(vector<string>& names, vector<int>& heights) {
        map<int, string> nameMap;
        for (int i = 0; i < names.size(); ++i) {
            nameMap[heights[i]] = names[i];
        }
        vector<string> sortedNames;
        for (auto it = nameMap.rbegin(); it != nameMap.rend(); ++it) {
            sortedNames.push_back(it->second);
        }
        return sortedNames;
    }
};