class Solution {
public:
    int minTimeToType(string word) {
        int time = 0, currentPos = 0;
        for (char c : word) {
            int targetPos = c - 'a';
            int dist = abs(targetPos - currentPos);
            time += min(dist, 26 - dist) + 1;
            currentPos = targetPos;
        }
        return time;
    }
};