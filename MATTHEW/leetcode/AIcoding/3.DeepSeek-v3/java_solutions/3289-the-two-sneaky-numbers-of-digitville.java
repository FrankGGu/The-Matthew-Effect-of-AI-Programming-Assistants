class Solution {
    public int[] twoSneakyNumbers(int[] digits) {
        int n = digits.length;
        int[] res = new int[2];
        int xor = 0;
        for (int num : digits) {
            xor ^= num;
        }
        int diffBit = xor & -xor;
        int num1 = 0, num2 = 0;
        for (int num : digits) {
            if ((num & diffBit) == 0) {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }
        res[0] = num1;
        res[1] = num2;
        return res;
    }
}