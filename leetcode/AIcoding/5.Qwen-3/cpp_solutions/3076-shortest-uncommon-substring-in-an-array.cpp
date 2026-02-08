#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestUncommonSubstring(string& s, vector<string>& queries) {
        int n = s.size();
        unordered_map<string, int> count;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                count[sub]++;
            }
        }

        vector<string> result(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            string q = queries[i];
            if (count[q] == 1) {
                result[i] = q;
            } else {
                int len = q.length();
                bool found = false;
                for (int l = 1; l <= len; ++l) {
                    for (int i_sub = 0; i_sub <= len - l; ++i_sub) {
                        string sub = q.substr(i_sub, l);
                        if (count[sub] == 1) {
                            result[i] = sub;
                            found = true;
                            break;
                        }
                    }
                    if (found) break;
                }
            }
        }
        return result[0];
    }
};