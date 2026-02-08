class Solution {
public:
    char findKthCharacter(string s, int k) {
        int n = s.size();
        int len = 1, total = 0;

        while (total < k) {
            total += len * n;
            len++;
        }

        total -= len * n;
        len--;

        k -= total;

        while (len > 0) {
            int groupSize = pow(2, len - 1);
            if (k > groupSize) {
                k -= groupSize;
                s = s.substr(n, n);
            } else {
                s = s.substr(0, n);
            }
            len--;
        }

        return s[k - 1];
    }
};