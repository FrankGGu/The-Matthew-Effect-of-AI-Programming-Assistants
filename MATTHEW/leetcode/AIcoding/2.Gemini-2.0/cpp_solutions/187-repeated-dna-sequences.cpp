#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s, int k = 10) {
        vector<string> result;
        if (s.length() < k) {
            return result;
        }

        unordered_set<string> seen;
        unordered_set<string> repeated;

        for (int i = 0; i <= (int)s.length() - k; ++i) {
            string sub = s.substr(i, k);
            if (seen.count(sub)) {
                repeated.insert(sub);
            } else {
                seen.insert(sub);
            }
        }

        for (const string& str : repeated) {
            result.push_back(str);
        }

        return result;
    }
};