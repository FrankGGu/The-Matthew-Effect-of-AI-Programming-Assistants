class Solution {
    public int[] sumOfThree(int num) {
        if (num % 3 == 0) {
            return new int[]{num / 3 - 1, num / 3, num / 3 + 1};
        }
        return new int[]{};
    }
}