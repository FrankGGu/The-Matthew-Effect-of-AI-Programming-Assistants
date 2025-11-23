class Solution {
public:
    int findTheLongestSubstring(string s) {
        unordered_map<int, int> index;
        index[0] = -1;
        int maxLength = 0, mask = 0;

        for (int i = 0; i < s.size(); i++) {
            switch (s[i]) {
                case 'a': mask ^= 1 << 0; break;
                case 'e': mask ^= 1 << 1; break;
                case 'i': mask ^= 1 << 2; break;
                case 'o': mask ^= 1 << 3; break;
                case 'u': mask ^= 1 << 4; break;
            }

            if (index.find(mask) != index.end()) {
                maxLength = max(maxLength, i - index[mask]);
            } else {
                index[mask] = i;
            }
        }

        return maxLength;
    }
};