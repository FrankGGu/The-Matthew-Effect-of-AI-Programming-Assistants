class Solution {
public:
    int closetTarget(vector<string>& words, string target, int startIndex) {
        int n = words.size();
        int minDist = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (words[i] == target) {
                int dist = abs(i - startIndex);
                dist = min(dist, n - dist);
                if (dist < minDist) {
                    minDist = dist;
                }
            }
        }
        return minDist == INT_MAX ? -1 : minDist;
    }
};