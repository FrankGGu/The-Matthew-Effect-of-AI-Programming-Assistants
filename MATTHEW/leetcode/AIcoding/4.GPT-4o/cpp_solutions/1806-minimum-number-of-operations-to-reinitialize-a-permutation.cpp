class Solution {
public:
    int reinitializePermutation(int n) {
        int count = 0, perm = 1;
        while (count == 0 || perm != 1) {
            perm = (perm % 2) * (n / 2) + (perm / 2);
            count++;
        }
        return count;
    }
};