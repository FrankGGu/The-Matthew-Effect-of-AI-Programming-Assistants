class Solution {
public:
    int minTimeToType(string word) {
        int time = 0;
        char current = 'a';
        for (char c : word) {
            int diff = abs(c - current);
            time += min(diff, 26 - diff) + 1;
            current = c;
        }
        return time;
    }
};