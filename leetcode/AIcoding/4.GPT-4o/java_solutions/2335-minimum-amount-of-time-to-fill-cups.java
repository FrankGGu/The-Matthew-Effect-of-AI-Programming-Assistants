import java.util.Arrays;

class Solution {
    public int fillCups(int[] amount) {
        Arrays.sort(amount);
        int time = 0;
        while (amount[2] > 0) {
            amount[2]--;
            time++;
            if (amount[1] > 0) {
                amount[1]--;
            }
            Arrays.sort(amount);
        }
        return time;
    }
}