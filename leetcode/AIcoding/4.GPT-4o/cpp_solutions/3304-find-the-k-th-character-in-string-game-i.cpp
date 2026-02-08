class Solution {
public:
    char findKthCharacter(string s, int k) {
        int n = s.size();
        int len = 1, count = 0;

        while (true) {
            count += len;
            if (count >= k) {
                break;
            }
            len++;
        }

        int index = k - (count - len) - 1;
        return s[index % n];
    }
};