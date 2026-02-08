#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int secondsToRemoveOccurrences(string s) {
        int seconds = 0;
        while (true) {
            bool swapped = false;
            for (int i = 0; i < s.length() - 1; ++i) {
                if (s[i] == '0' && s[i + 1] == '1') {
                    swap(s[i], s[i + 1]);
                    swapped = true;
                    ++i;
                }
            }
            if (!swapped) {
                break;
            }
            ++seconds;
        }
        return seconds;
    }
};