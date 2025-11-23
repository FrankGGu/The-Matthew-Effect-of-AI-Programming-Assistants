#include <string>
#include <algorithm>

class Solution {
public:
    int minTimeToType(string word) {
        int time = word.size();
        int pos = 0;

        for (char c : word) {
            int target = c - 'a';
            time += std::min(abs(target - pos), 26 - abs(target - pos));
            pos = target;
        }

        return time;
    }
};