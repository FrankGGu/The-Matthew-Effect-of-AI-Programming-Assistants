public class Solution {

class Solution {
    public int signOfProduct(int[] nums) {
        int negativeCount = 0;
        for (int num : nums) {
            if (num == 0) {
                return 0;
            }
            if (num < 0) {
                negativeCount++;
            }
        }
        return negativeCount % 2 == 0 ? 1 : -1;
    }
}
}