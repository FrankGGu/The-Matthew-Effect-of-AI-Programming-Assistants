#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        unordered_set<string> seen;
        unordered_set<string> result;
        for (int i = 0; i + 9 < s.size(); ++i) {
            string seq = s.substr(i, 10);
            if (seen.find(seq) != seen.end()) {
                result.insert(seq);
            } else {
                seen.insert(seq);
            }
        }
        return vector<string>(result.begin(), result.end());
    }
};