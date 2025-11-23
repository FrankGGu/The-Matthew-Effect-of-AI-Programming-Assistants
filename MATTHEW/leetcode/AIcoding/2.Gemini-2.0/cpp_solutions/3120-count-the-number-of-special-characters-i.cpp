#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countTheNumberofSpecialCharacters(string word) {
        unordered_set<char> seen;
        int count = 0;
        for (char c : word) {
            if (seen.find(c) == seen.end()) {
                seen.insert(c);
            } else {
                count++;
            }
        }
        return count;
    }
};