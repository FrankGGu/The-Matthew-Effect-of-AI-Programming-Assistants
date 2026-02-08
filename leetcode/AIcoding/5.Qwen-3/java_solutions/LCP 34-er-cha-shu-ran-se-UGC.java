public class Solution {
    public int minTimeToType(String keyboard, String word) {
        int time = 0;
        int currentPos = 0;
        for (char c : word.toCharArray()) {
            int targetPos = keyboard.indexOf(c);
            time += Math.abs(targetPos - currentPos);
            time += 1;
            currentPos = targetPos;
        }
        return time;
    }
}