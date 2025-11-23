#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s, int k) {
        vector<string> result;
        if (s.length() < k) {
            return result;
        }

        unordered_map<string, int> count;
        for (int i = 0; i <= (int)s.length() - k; ++i) {
            string sub = s.substr(i, k);
            count[sub]++;
            if (count[sub] == 2) {
                result.push_back(sub);
            }
        }

        return result;
    }
};