public class Solution {
    public boolean reachPoint(int sx, int sy, int tx, int ty) {
        while (tx >= sx && ty >= sy && tx != ty) {
            if (tx > ty) {
                if (ty > sy) tx = tx % ty;
                else break;
            } else {
                if (tx > sx) ty = ty % tx;
                else break;
            }
        }
        return (tx == sx && ty >= sy) || (ty == sy && tx >= sx);
    }
}