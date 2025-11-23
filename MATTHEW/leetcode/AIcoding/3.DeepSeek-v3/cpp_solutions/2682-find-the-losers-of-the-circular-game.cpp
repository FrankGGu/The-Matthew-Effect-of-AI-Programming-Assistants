class Solution {
public:
    vector<int> circularGameLosers(int n, int k) {
        vector<bool> visited(n, false);
        int current = 0;
        int step = 1;
        while (!visited[current]) {
            visited[current] = true;
            current = (current + step * k) % n;
            step++;
        }
        vector<int> losers;
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                losers.push_back(i + 1);
            }
        }
        return losers;
    }
};