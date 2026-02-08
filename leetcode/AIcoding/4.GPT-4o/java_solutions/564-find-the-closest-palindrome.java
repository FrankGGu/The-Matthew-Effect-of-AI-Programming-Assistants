import java.util.TreeSet;

public class Solution {
    public String nearestPalindromic(String n) {
        TreeSet<Long> candidates = new TreeSet<>();
        long num = Long.parseLong(n);
        candidates.add((long) Math.pow(10, n.length() - 1) - 1);
        candidates.add((long) Math.pow(10, n.length()));

        long prefix = Long.parseLong(n.substring(0, (n.length() + 1) / 2));

        for (long i = prefix - 1; i <= prefix + 1; i++) {
            StringBuilder sb = new StringBuilder(Long.toString(i));
            String palindrome = sb.toString() + sb.reverse().substring(n.length() % 2);
            candidates.add(Long.parseLong(palindrome));
        }

        candidates.remove(num);

        long closest = Long.MAX_VALUE;
        for (long candidate : candidates) {
            if (Math.abs(candidate - num) < Math.abs(closest - num) || 
                (Math.abs(candidate - num) == Math.abs(closest - num) && candidate < closest)) {
                closest = candidate;
            }
        }

        return Long.toString(closest);
    }
}