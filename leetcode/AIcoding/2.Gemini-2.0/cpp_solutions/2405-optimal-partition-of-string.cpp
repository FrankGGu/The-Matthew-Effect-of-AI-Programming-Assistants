#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int partitionString(string s) {
        int count = 1;
        unordered_set<char> seen;
        for (char c : s) {
            if (seen.count(c)) {
                count++;
                seen.clear();
            }
            seen.insert(c);
        }
        return count;
    }
};