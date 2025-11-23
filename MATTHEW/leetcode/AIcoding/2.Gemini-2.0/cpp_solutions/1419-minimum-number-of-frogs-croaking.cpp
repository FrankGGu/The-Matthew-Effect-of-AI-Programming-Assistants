#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumberOfFrogs(string croakOfFrogs) {
        vector<int> counts(5, 0);
        int frogs = 0;
        int maxFrogs = 0;

        for (char c : croakOfFrogs) {
            if (c == 'c') {
                counts[0]++;
                frogs++;
                maxFrogs = max(maxFrogs, frogs);
            } else if (c == 'r') {
                counts[1]++;
                if (counts[0] == 0) return -1;
                counts[0]--;
            } else if (c == 'o') {
                counts[2]++;
                if (counts[1] == 0) return -1;
                counts[1]--;
            } else if (c == 'a') {
                counts[3]++;
                if (counts[2] == 0) return -1;
                counts[2]--;
            } else if (c == 'k') {
                counts[4]++;
                if (counts[3] == 0) return -1;
                counts[3]--;
                frogs--;
            }
        }

        for (int count : counts) {
            if (count != 0) return -1;
        }

        return maxFrogs;
    }
};