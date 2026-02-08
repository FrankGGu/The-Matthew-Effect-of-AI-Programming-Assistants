public class Solution {
    public char kthCharacter(int n, int k) {
        int length = 1;
        while (length < k) {
            length *= 2;
        }
        char result = 'a';
        while (length > 1) {
            length /= 2;
            if (k > length) {
                k -= length;
                result++;
            }
        }
        return result;
    }
}