#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closetTarget(vector<string>& words, string target, int startIndex) {
        int n = words.size();
        int min_dist = INT_MAX;

        for (int i = 0; i < n; ++i) {
            if (words[i] == target) {
                int dist = abs(i - startIndex);
                min_dist = min(min_dist, min(dist, n - dist));
            }
        }

        if (min_dist == INT_MAX) {
            return -1;
        }

        return min_dist;
    }
};