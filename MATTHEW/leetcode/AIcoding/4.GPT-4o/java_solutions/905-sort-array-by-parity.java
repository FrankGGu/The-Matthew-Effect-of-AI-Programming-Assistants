class Solution {
    public int[] sortArrayByParity(int[] A) {
        int[] result = new int[A.length];
        int evenIndex = 0;
        int oddIndex = A.length - 1;

        for (int num : A) {
            if (num % 2 == 0) {
                result[evenIndex++] = num;
            } else {
                result[oddIndex--] = num;
            }
        }

        return result;
    }
}