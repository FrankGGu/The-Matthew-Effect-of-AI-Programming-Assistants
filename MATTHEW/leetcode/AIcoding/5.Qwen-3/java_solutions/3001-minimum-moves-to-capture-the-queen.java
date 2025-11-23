public class Solution {
    public int minMovesToCaptureTheQueen(int[] rook, int[] bishop, int[] queen) {
        int rx = rook[0], ry = rook[1];
        int bx = bishop[0], by = bishop[1];
        int qx = queen[0], qy = queen[1];

        boolean isRookInLine = (rx == qx || ry == qy);
        boolean isBishopInLine = (Math.abs(bx - qx) == Math.abs(by - qy));

        if (isRookInLine && isBishopInLine) {
            int minRow = Math.min(rx, qx);
            int maxRow = Math.max(rx, qx);
            int minCol = Math.min(ry, qy);
            int maxCol = Math.max(ry, qy);

            if (rx == qx) {
                for (int i = minCol + 1; i < maxCol; i++) {
                    if (bx == rx && by == i) return 2;
                }
            } else {
                for (int i = minRow + 1; i < maxRow; i++) {
                    if (bx == i && by == ry) return 2;
                }
            }
        }

        return 2;
    }
}