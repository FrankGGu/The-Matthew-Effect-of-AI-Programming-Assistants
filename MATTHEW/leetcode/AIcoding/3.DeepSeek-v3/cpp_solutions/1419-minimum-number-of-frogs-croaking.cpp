class Solution {
public:
    int minNumberOfFrogs(string croakOfFrogs) {
        vector<int> count(5, 0);
        int frogs = 0, max_frogs = 0;
        unordered_map<char, int> m = {{'c', 0}, {'r', 1}, {'o', 2}, {'a', 3}, {'k', 4}};

        for (char c : croakOfFrogs) {
            int idx = m[c];
            count[idx]++;
            if (idx > 0 && count[idx] > count[idx-1]) {
                return -1;
            }
            if (idx == 0) {
                frogs++;
                max_frogs = max(max_frogs, frogs);
            } else if (idx == 4) {
                frogs--;
            }
        }

        if (count[0] != count[4] || count[1] != count[4] || count[2] != count[4] || count[3] != count[4]) {
            return -1;
        }

        return max_frogs;
    }
};