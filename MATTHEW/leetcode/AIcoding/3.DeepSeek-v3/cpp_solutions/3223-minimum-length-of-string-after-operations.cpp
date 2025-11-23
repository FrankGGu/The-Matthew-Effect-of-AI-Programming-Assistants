class Solution {
public:
    int minimumLength(string s) {
        int left = 0, right = s.size() - 1;
        while (left < right && s[left] == s[right]) {
            char current = s[left];
            while (left <= right && s[left] == current) {
                left++;
            }
            while (left <= right && s[right] == current) {
                right--;
            }
        }
        return right - left + 1;
    }
};