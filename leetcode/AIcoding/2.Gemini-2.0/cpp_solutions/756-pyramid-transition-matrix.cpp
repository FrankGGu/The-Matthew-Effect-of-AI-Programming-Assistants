#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool pyramidTransition(string bottom, vector<string>& allowed) {
        unordered_map<string, unordered_set<char>> allowedMap;
        for (const string& s : allowed) {
            allowedMap[s.substr(0, 2)].insert(s[2]);
        }

        function<bool(string)> solve = [&](string current) {
            if (current.length() == 1) {
                return true;
            }

            string next = "";
            vector<string> possibleNextRows;
            possibleNextRows.push_back("");

            for (int i = 0; i < current.length() - 1; ++i) {
                string key = current.substr(i, 2);
                vector<string> temp;
                for (const string& prevRow : possibleNextRows) {
                    if (allowedMap.count(key)) {
                        for (char c : allowedMap[key]) {
                            temp.push_back(prevRow + c);
                        }
                    }
                }
                possibleNextRows = temp;
            }

            for (const string& nextRow : possibleNextRows) {
                if (solve(nextRow)) {
                    return true;
                }
            }

            return false;
        };

        return solve(bottom);
    }
};