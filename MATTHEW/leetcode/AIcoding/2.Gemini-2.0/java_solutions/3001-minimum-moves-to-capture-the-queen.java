class Solution {
    public int minMovesToCaptureTheQueen(int rx, int ry, int bx, int by, int qx, int qy) {
        int ans = 2;

        if (canRookCapture(rx, ry, qx, qy, bx, by)) {
            ans = 1;
        }

        if (canBishopCapture(bx, by, qx, qy, rx, ry)) {
            ans = Math.min(ans, 1);
        }

        if (canKingCapture(rx, ry, qx, qy) || canKingCapture(bx, by, qx, qy)) {
            ans = Math.min(ans, 2);
        }

        return ans;
    }

    private boolean canRookCapture(int rx, int ry, int qx, int qy, int bx, int by) {
        if (rx == qx) {
            if ((by == ry || by == qy) && ((ry < by && by < qy) || (qy < by && by < ry))) {
                return false;
            }
            return true;
        }

        if (ry == qy) {
            if ((bx == rx || bx == qx) && ((rx < bx && bx < qx) || (qx < bx && bx < rx))) {
                return false;
            }
            return true;
        }

        return false;
    }

    private boolean canBishopCapture(int bx, int by, int qx, int qy, int rx, int ry) {
        if (Math.abs(bx - qx) == Math.abs(by - qy)) {
            if (Math.abs(rx - bx) == Math.abs(ry - by) && Math.abs(rx - qx) == Math.abs(ry - qy)) {
                if (((bx < rx && rx < qx) || (qx < rx && rx < bx)) && ((by < ry && ry < qy) || (qy < ry && ry < by))) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    private boolean canKingCapture(int x1, int y1, int x2, int y2) {
        return Math.abs(x1 - x2) <= 1 && Math.abs(y1 - y2) <= 1;
    }
}