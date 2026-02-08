class Solution {
public:
    int mirrorReflection(int p, int q) {
        int ext = q, ref = p;
        while (ext % p != 0) {
            int k = p;
            p = q;
            q = k % q;
            ext += ref;
        }
        int m = ext / p;
        int n = ext / ref;
        if (m % 2 == 0) return 2;
        if (n % 2 == 0) return 0;
        return 1;
    }
};