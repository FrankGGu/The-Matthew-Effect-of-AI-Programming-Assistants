#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int videoStitching(vector<vector<int>>& clips, int T) {
        vector<int> maxEnd(T, 0);
        for (const auto& clip : clips) {
            int start = clip[0];
            int end = clip[1];
            if (start < T) {
                maxEnd[start] = max(maxEnd[start], end);
            }
        }

        int res = 0;
        int currEnd = 0;
        int nextEnd = 0;
        for (int i = 0; i < T; ++i) {
            if (i > currEnd) {
                return -1;
            }
            nextEnd = max(nextEnd, maxEnd[i]);
            if (i == currEnd) {
                res++;
                currEnd = nextEnd;
                if (currEnd >= T) {
                    break;
                }
            }
        }
        return res;
    }
};