public class Solution {
    public boolean prefixesDivBy6(int[] A) {
        int prefix = 0;
        for (int num : A) {
            prefix = (prefix * 2 + num) % 6;
            if (prefix % 5 != 0) {
                return false;
            }
        }
        return true;
    }
}