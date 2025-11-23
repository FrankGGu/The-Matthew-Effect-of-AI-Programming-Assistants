public class Solution {
    public String longestHappyString(int a, int b, int c) {
        StringBuilder sb = new StringBuilder();
        int[] counts = {a, b, c};
        char[] chars = {'a', 'b', 'c'};

        while (true) {
            int maxCount = -1;
            int maxIndex = -1;
            for (int i = 0; i < 3; i++) {
                if (counts[i] > maxCount && sb.length() < 2 || sb.length() >= 2 && sb.charAt(sb.length() - 1) != chars[i] && sb.charAt(sb.length() - 2) != chars[i]) {
                    maxCount = counts[i];
                    maxIndex = i;
                }
            }
            if (maxIndex == -1) break;
            sb.append(chars[maxIndex]);
            counts[maxIndex]--;
        }

        return sb.toString();
    }
}