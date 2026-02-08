public class Solution {
    public String largestNumber(String s) {
        int[] count = new int[10];
        for (char c : s.toCharArray()) {
            count[c - '0']++;
        }
        StringBuilder result = new StringBuilder();
        for (int i = 9; i >= 0; i--) {
            if (count[i] >= 3) {
                int k = count[i] / 3;
                for (int j = 0; j < k; j++) {
                    result.append(i);
                }
            }
        }
        return result.length() == 0 ? "0" : result.toString();
    }
}