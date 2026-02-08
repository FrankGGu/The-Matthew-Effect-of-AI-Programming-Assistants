#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxLengthBetweenEqualCharacters(vector<char>& s) {
        vector<int> lastOccurrence(26, -1);
        int maxLength = -1;

        for (int i = 0; i < s.size(); ++i) {
            int index = s[i] - 'a';
            if (lastOccurrence[index] != -1) {
                maxLength = max(maxLength, i - lastOccurrence[index] - 1);
            } else {
                lastOccurrence[index] = i;
            }
        }

        return maxLength;
    }
};