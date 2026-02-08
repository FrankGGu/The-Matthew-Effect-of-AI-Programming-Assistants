#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minLength(string s1, string s2) {
        unordered_map<char, int> count;
        for (char c : s1) count[c]++;
        for (char c : s2) count[c]--;

        int length = 0;
        for (auto& entry : count) {
            length += abs(entry.second);
        }
        return length;
    }
};