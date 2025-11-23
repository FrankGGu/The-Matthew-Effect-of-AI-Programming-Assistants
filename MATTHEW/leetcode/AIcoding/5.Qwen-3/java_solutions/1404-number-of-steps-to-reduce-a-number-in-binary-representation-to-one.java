public class Solution {
    public int numSteps(String s) {
        int steps = 0;
        int n = s.length();
        for (int i = n - 1; i > 0; i--) {
            if (s.charAt(i) == '1') {
                steps += 2;
                if (i - 1 >= 0 && s.charAt(i - 1) == '0') {
                    steps--;
                }
            } else {
                steps++;
            }
        }
        return steps;
    }
}