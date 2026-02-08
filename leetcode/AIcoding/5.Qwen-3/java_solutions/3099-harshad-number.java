public class Solution {
    public boolean isHarshad(int x) {
        int original = x;
        int sum = 0;
        while (x > 0) {
            sum += x % 10;
            x /= 10;
        }
        return original % sum == 0;
    }
}