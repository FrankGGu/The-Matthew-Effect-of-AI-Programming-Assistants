#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int distinctNames(vector<string>& ideas) {
        unordered_map<char, unordered_set<string>> map;
        for (string& idea : ideas) {
            map[idea[0]].insert(idea.substr(1));
        }

        int result = 0;
        for (auto it1 = map.begin(); it1 != map.end(); ++it1) {
            for (auto it2 = next(it1); it2 != map.end(); ++it2) {
                int common = 0;
                for (const string& s : it1->second) {
                    if (it2->second.find(s) != it2->second.end()) {
                        ++common;
                    }
                }
                int count1 = it1->second.size() - common;
                int count2 = it2->second.size() - common;
                result += count1 * count2 * 2;
            }
        }
        return result;
    }
};