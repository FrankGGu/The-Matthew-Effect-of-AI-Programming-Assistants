public class Solution {
    public String longestString(int a, int b, int c) {
        StringBuilder sb = new StringBuilder();
        int[] count = {a, b, c};
        char[] chars = {'a', 'b', 'c'};

        while (true) {
            boolean added = false;
            for (int i = 0; i < 3; i++) {
                if (count[i] > 0 && sb.length() == 0 || sb.length() > 0 && sb.charAt(sb.length() - 1) != chars[i]) {
                    sb.append(chars[i]);
                    count[i]--;
                    added = true;
                    break;
                }
            }
            if (!added) break;
        }

        return sb.toString();
    }
}