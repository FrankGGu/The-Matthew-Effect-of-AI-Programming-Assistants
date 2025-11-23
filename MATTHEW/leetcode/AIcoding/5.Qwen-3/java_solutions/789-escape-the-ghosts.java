public class Solution {
    public int escapeGhosts(int[] ghosts, int[] target) {
        int playerDistance = Math.abs(target[0]) + Math.abs(target[1]);
        for (int[] ghost : ghosts) {
            int ghostDistance = Math.abs(ghost[0] - target[0]) + Math.abs(ghost[1] - target[1]);
            if (ghostDistance <= playerDistance) {
                return 0;
            }
        }
        return 1;
    }
}