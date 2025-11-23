#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        unordered_map<string, int> sequenceCount;
        unordered_set<string> result;
        for (int i = 0; i + 10 <= s.size(); ++i) {
            string sequence = s.substr(i, 10);
            sequenceCount[sequence]++;
            if (sequenceCount[sequence] == 2) {
                result.insert(sequence);
            }
        }
        return vector<string>(result.begin(), result.end());
    }
};