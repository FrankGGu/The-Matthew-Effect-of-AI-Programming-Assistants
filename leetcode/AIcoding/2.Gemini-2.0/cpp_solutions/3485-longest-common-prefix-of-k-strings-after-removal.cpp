#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestCommonPrefixAfterRemoval(vector<string>& strs) {
        if (strs.empty()) {
            return "";
        }

        string first = strs[0];
        int n = first.length();
        int k = strs.size();

        string longestPrefix = "";

        for (int i = 0; i < n; ++i) {
            string prefix = first.substr(0, i + 1);
            bool possible = true;

            for (int j = 0; j < k; ++j) {
                if (strs[j] == first) continue;
                if (strs[j].find(prefix) == string::npos) {
                    bool found = false;
                    for (int l = 0; l < strs[j].length(); ++l) {
                        string temp = strs[j];
                        temp.erase(l, 1);
                        if (temp.find(prefix) != string::npos) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        possible = false;
                        break;
                    }
                }
            }

            if (possible) {
                longestPrefix = prefix;
            } else {
                break;
            }
        }

        return longestPrefix;
    }
};