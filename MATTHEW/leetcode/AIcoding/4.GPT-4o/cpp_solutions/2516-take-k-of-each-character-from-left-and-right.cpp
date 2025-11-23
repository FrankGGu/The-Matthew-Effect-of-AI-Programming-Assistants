class Solution {
public:
    string takeCharacters(string s, int k) {
        unordered_map<char, int> count;
        for (char c : s) count[c]++;

        int left = 0, right = 0, n = s.size();
        int need = 0;
        for (auto& [_, v] : count) {
            if (v < k) need += k - v;
        }

        string res = s;
        while (right < n) {
            while (right < n && need > 0) {
                if (--count[s[right]] < k) {
                    need--;
                }
                right++;
            }
            if (need == 0) {
                res = min(res, s.substr(left, right - left));
            }
            if (left < right && count[s[left]] < k) {
                need++;
            }
            left++;
        }

        return res;
    }
};