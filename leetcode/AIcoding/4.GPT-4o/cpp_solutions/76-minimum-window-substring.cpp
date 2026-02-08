class Solution {
public:
    string minWindow(string s, string t) {
        if (t.size() > s.size()) return "";
        unordered_map<char, int> dictT, window;
        for (char c : t) dictT[c]++;

        int l = 0, r = 0, required = dictT.size(), formed = 0;
        int minLen = INT_MAX, minLeft = 0;

        while (r < s.size()) {
            char c = s[r];
            window[c]++;
            if (dictT.count(c) && window[c] == dictT[c]) formed++;

            while (l <= r && formed == required) {
                c = s[l];
                if (r - l + 1 < minLen) {
                    minLen = r - l + 1;
                    minLeft = l;
                }
                window[c]--;
                if (dictT.count(c) && window[c] < dictT[c]) formed--;
                l++;
            }
            r++;
        }

        return minLen == INT_MAX ? "" : s.substr(minLeft, minLen);
    }
};