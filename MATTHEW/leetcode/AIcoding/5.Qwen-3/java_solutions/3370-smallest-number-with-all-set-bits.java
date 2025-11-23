public class Solution {
    public int smallestNumber(int[] given) {
        int result = 0;
        for (int num : given) {
            result |= num;
        }
        return result;
    }
}