#include <vector>
#include <string>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numSpecialEquivGroups(vector<string>& A) {
        set<string> unique_strings;
        for (string& s : A) {
            string even = "";
            string odd = "";
            for (int i = 0; i < s.length(); ++i) {
                if (i % 2 == 0) {
                    even += s[i];
                } else {
                    odd += s[i];
                }
            }
            sort(even.begin(), even.end());
            sort(odd.begin(), odd.end());
            unique_strings.insert(even + odd);
        }
        return unique_strings.size();
    }
};