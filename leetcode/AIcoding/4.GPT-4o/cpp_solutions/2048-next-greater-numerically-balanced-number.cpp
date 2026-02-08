class Solution {
public:
    int nextBalanced(int n) {
        string s = to_string(n);
        int len = s.size();

        for (int i = len - 1; i > 0; --i) {
            if (s[i] > s[i - 1]) {
                int j = len - 1;
                while (s[j] <= s[i - 1]) --j;
                swap(s[i - 1], s[j]);
                reverse(s.begin() + i, s.end());
                return stoi(s);
            }
        }

        return -1;
    }
};