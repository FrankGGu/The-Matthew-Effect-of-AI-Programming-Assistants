class Solution {
public:
    int balancedString(string s) {
        unordered_map<char, int> count;
        for (char c : s) count[c]++;
        int n = s.size(), target = n / 4;
        if (count['Q'] == target && count['W'] == target && count['E'] == target && count['R'] == target) return 0;

        int left = 0, min_length = n;
        for (int right = 0; right < n; right++) {
            count[s[right]]--;
            while (count['Q'] <= target && count['W'] <= target && count['E'] <= target && count['R'] <= target) {
                min_length = min(min_length, right - left + 1);
                count[s[left]]++;
                left++;
            }
        }
        return min_length;
    }
};