class Solution {
    public int smallestNumberWithAllSetBits(int n) {
        int ans = 0;
        for (int i = 0; i < 32; i++) {
            if (n > 0) {
                ans |= (1 << i);
                n--;
            } else {
                break;
            }
        }
        return ans;
    }
}