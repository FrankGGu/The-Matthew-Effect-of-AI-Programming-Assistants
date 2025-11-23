bool canReach(int sx, int sy, int tx, int ty) {
    while (tx >= sx && ty >= sy) {
        if (tx == sx && ty == sy) return true;
        if (tx > ty) {
            tx -= (tx - sx) / tx * tx; // Reduce tx to range [sx, tx]
        } else {
            ty -= (ty - sy) / ty * ty; // Reduce ty to range [sy, ty]
        }
    }
    return (sx == tx && ty >= sy && (ty - sy) % sx == 0) || (sy == ty && tx >= sx && (tx - sx) % sy == 0);
}