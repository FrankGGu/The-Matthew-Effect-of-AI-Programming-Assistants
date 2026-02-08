import java.util.Arrays;
import java.util.stream.IntStream;

class Solution {
    public boolean isGoodArray(int[] nums) {
        int gcd = Arrays.stream(nums).reduce(nums[0], this::gcd);
        return gcd == 1;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}