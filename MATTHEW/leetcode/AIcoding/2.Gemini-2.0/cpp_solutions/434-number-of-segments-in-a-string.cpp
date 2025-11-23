#include <string>

using namespace std;

class Solution {
public:
    int countSegments(string s) {
        int count = 0;
        bool in_segment = false;
        for (char c : s) {
            if (c == ' ') {
                if (in_segment) {
                    count++;
                    in_segment = false;
                }
            } else {
                in_segment = true;
            }
        }
        if (in_segment) {
            count++;
        }
        return count;
    }
};