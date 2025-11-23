import java.util.Arrays;

class Solution {
    public boolean reorderedPowerOf2(int n) {
        char[] num = String.valueOf(n).toCharArray();
        Arrays.sort(num);
        String sortedNum = new String(num);

        for (int i = 0; i < 31; i++) {
            int powerOf2 = 1 << i;
            char[] powerOf2Chars = String.valueOf(powerOf2).toCharArray();
            Arrays.sort(powerOf2Chars);
            String sortedPowerOf2 = new String(powerOf2Chars);

            if (sortedNum.equals(sortedPowerOf2)) {
                return true;
            }
        }

        return false;
    }
}