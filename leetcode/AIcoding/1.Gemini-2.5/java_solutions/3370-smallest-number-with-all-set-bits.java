class Solution {
    public int smallestNumber(int k) {
        if (k == 0) {
            return 0;
        }
        return (1 << k) - 1;
    }
}