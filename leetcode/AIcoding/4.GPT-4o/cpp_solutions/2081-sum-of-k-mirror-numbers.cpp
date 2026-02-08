class Solution {
public:
    long long kMirror(int k, int n) {
        long long sum = 0;
        int count = 0;
        for (int i = 1; count < n; ++i) {
            if (isMirror(i, 10) && isMirror(i, k)) {
                sum += i;
                count++;
            }
        }
        return sum;
    }

private:
    bool isMirror(int num, int base) {
        string s = "";
        while (num > 0) {
            s += to_string(num % base);
            num /= base;
        }
        string rev = s;
        reverse(rev.begin(), rev.end());
        return s == rev;
    }
};