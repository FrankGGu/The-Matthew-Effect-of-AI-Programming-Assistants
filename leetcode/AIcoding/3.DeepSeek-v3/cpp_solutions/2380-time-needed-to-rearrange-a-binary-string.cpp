class Solution {
public:
    int secondsToRemoveOccurrences(string s) {
        int res = 0;
        bool changed;
        do {
            changed = false;
            for (int i = 0; i < s.size() - 1; ) {
                if (s[i] == '0' && s[i+1] == '1') {
                    swap(s[i], s[i+1]);
                    changed = true;
                    i += 2;
                } else {
                    i++;
                }
            }
            if (changed) res++;
        } while (changed);
        return res;
    }
};