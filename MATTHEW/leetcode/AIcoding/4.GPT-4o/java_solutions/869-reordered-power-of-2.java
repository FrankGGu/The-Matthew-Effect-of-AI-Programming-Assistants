import java.util.Arrays;

class Solution {
    public boolean reorderedPowerOf2(int N) {
        char[] num = Integer.toString(N).toCharArray();
        Arrays.sort(num);
        for (int i = 0; i < 31; i++) {
            char[] powerOfTwo = Integer.toString(1 << i).toCharArray();
            Arrays.sort(powerOfTwo);
            if (Arrays.equals(num, powerOfTwo)) {
                return true;
            }
        }
        return false;
    }
}