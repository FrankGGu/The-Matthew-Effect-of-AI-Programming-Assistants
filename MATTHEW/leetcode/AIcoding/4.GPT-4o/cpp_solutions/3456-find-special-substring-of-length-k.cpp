class Solution {
public:
    int specialSubstring(string s, int k) {
        int n = s.size();
        if (n < k) return 0;

        unordered_map<char, int> count;
        int uniqueCount = 0;
        int left = 0, result = 0;

        for (int right = 0; right < n; right++) {
            if (count[s[right]]++ == 0) uniqueCount++;

            while (uniqueCount > k) {
                if (--count[s[left]] == 0) uniqueCount--;
                left++;
            }

            if (uniqueCount == k) {
                result++;
                int tempLeft = left;
                while (count[s[tempLeft]] > 1) {
                    result++;
                    tempLeft++;
                }
            }
        }
        return result;
    }
};