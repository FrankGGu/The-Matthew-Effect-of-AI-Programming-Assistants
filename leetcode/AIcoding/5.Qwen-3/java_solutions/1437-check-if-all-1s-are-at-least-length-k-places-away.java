public class Solution {
    public boolean kLengthApart(String nums, int k) {
        int last = -1;
        for (int i = 0; i < nums.length(); i++) {
            if (nums.charAt(i) == '1') {
                if (last != -1 && i - last - 1 < k) {
                    return false;
                }
                last = i;
            }
        }
        return true;
    }
}