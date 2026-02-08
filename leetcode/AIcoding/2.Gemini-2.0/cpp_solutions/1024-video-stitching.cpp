#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int videoStitching(vector<vector<int>>& clips, int time) {
        sort(clips.begin(), clips.end());
        int n = clips.size();
        int ans = 0;
        int currEnd = 0;
        int nextEnd = 0;
        int i = 0;

        while (currEnd < time) {
            while (i < n && clips[i][0] <= currEnd) {
                nextEnd = max(nextEnd, clips[i][1]);
                i++;
            }

            if (currEnd == nextEnd) {
                return -1;
            }

            ans++;
            currEnd = nextEnd;
        }

        return ans;
    }
};