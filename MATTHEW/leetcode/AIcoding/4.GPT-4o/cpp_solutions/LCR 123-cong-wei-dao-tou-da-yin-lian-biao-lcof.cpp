class Solution {
public:
    int minTimeToType(string word) {
        int time = 0, current = 0;
        for (char c : word) {
            int target = c - 'a';
            int diff = abs(target - current);
            time += min(diff, 26 - diff) + 1;
            current = target;
        }
        return time;
    }
};