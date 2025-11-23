class Solution {
    public int smallestNumber(int num) {
        if (num == 0) {
            return 0;
        }
        int count = Integer.bitCount(num);
        int result = (1 << count) - 1;
        return result;
    }
}