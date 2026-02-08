#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool checkDistances(string s, vector<int>& distance) {
        vector<int> firstOccurrence(26, -1);
        for (int i = 0; i < s.length(); ++i) {
            int charIndex = s[i] - 'a';
            if (firstOccurrence[charIndex] == -1) {
                firstOccurrence[charIndex] = i;
            } else {
                int dist = i - firstOccurrence[charIndex] - 1;
                if (dist != distance[charIndex]) {
                    return false;
                }
            }
        }
        return true;
    }
};