#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> shortestSubstrings(vector<string>& arr) {
        unordered_map<string, int> substrCount;
        for (const string& s : arr) {
            int n = s.size();
            unordered_set<string> seen;
            for (int i = 0; i < n; ++i) {
                for (int j = i + 1; j <= n; ++j) {
                    string sub = s.substr(i, j - i);
                    if (seen.find(sub) == seen.end()) {
                        substrCount[sub]++;
                        seen.insert(sub);
                    }
                }
            }
        }

        vector<string> result;
        for (const string& s : arr) {
            int n = s.size();
            string shortest = "";
            for (int len = 1; len <= n && shortest.empty(); ++len) {
                for (int i = 0; i <= n - len; ++i) {
                    string sub = s.substr(i, len);
                    if (substrCount[sub] == 1) {
                        if (shortest.empty() || sub < shortest) {
                            shortest = sub;
                        }
                    }
                }
            }
            result.push_back(shortest);
        }
        return result;
    }
};