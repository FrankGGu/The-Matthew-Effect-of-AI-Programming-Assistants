function reachPoints(sx, sy, tx, ty) {
    while (tx >= sx && ty >= sy) {
        if (tx === sx && ty === sy) return true;
        if (tx > ty) {
            if (ty > sy) tx = tx % ty;
            else break;
        } else {
            if (tx > sx) ty = ty % tx;
            else break;
        }
    }
    return false;
}