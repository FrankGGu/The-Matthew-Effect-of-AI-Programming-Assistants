class Solution {
public:
    string decodeAtIndex(string S, int K) {
        long long size = 0;
        for (char c : S) {
            if (isdigit(c)) {
                size *= c - '0';
            } else {
                size++;
            }
        }

        for (int i = S.size() - 1; i >= 0; i--) {
            K %= size;
            if (K == 0 && !isdigit(S[i])) {
                return string(1, S[i]);
            }
            if (isdigit(S[i])) {
                size /= S[i] - '0';
            } else {
                size--;
            }
        }

        return "";
    }
};