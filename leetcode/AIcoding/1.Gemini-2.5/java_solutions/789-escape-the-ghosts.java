class Solution {
    public boolean escapeGhosts(int[][] ghosts, int[] target) {
        int playerTime = Math.abs(target[0]) + Math.abs(target[1]);

        for (int[] ghost : ghosts) {
            int ghostTime = Math.abs(target[0] - ghost[0]) + Math.abs(target[1] - ghost[1]);
            if (ghostTime <= playerTime) {
                return false;
            }
        }

        return true;
    }
}