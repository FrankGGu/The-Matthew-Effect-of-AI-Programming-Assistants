public class Solution {
    public boolean canCatchUp(int[] position, int[] speed, int time) {
        double catchUpTime = (double) (position[1] - position[0]) / (speed[0] - speed[1]);
        return catchUpTime <= time && catchUpTime >= 0;
    }
}