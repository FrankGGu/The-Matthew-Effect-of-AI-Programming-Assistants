#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxLengthBetweenEqualCharacters(string s) {
        unordered_map<char, int> first_occurrence;
        int max_length = -1;

        for (int i = 0; i < s.length(); ++i) {
            if (first_occurrence.find(s[i]) == first_occurrence.end()) {
                first_occurrence[s[i]] = i;
            } else {
                max_length = max(max_length, i - first_occurrence[s[i]] - 1);
            }
        }

        return max_length;
    }
};