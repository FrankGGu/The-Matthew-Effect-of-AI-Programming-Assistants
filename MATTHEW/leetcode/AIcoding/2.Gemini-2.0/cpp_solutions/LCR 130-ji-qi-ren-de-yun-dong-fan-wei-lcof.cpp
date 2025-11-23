#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closetTarget(vector<string>& words, string target, int startIndex) {
        int n = words.size();
        int ans = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (words[i] == target) {
                int dist1 = abs(i - startIndex);
                int dist2 = n - abs(i - startIndex);
                ans = min(ans, min(dist1, dist2));
            }
        }
        if (ans == INT_MAX) return -1;
        return ans;
    }
};