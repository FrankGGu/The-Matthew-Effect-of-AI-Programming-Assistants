import java.util.Arrays;

public class Solution {
    public int distributeCookies(int[] cookies, int k) {
        int[] children = new int[k];
        return backtrack(cookies, children, 0);
    }

    private int backtrack(int[] cookies, int[] children, int index) {
        if (index == cookies.length) {
            return Arrays.stream(children).max().getAsInt();
        }

        int min = Integer.MAX_VALUE;
        for (int i = 0; i < children.length; i++) {
            children[i] += cookies[index];
            min = Math.min(min, backtrack(cookies, children, index + 1));
            children[i] -= cookies[index];
            if (children[i] == 0) break; // optimization
        }
        return min;
    }
}