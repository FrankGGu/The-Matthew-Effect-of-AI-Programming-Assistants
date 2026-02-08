public class Solution {
    public char kthCharacter(long n, long k) {
        long length = 1;
        long power = 1;
        while (length < k) {
            power *= 2;
            length += power;
        }
        return (char) ('a' + (k - 1) % 26);
    }
}