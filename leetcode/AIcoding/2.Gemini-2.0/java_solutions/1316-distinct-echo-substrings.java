import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctEchoSubstrings(String text) {
        Set<String> distinctSubstrings = new HashSet<>();
        int n = text.length();

        for (int len = 1; len <= n / 2; len++) {
            for (int i = 0; i <= n - 2 * len; i++) {
                String firstHalf = text.substring(i, i + len);
                String secondHalf = text.substring(i + len, i + 2 * len);

                if (firstHalf.equals(secondHalf)) {
                    distinctSubstrings.add(firstHalf);
                }
            }
        }

        return distinctSubstrings.size();
    }
}