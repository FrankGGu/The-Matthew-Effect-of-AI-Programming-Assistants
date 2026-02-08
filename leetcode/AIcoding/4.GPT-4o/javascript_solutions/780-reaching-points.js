var canReach = function(sx, sy, tx, ty) {
    while (tx >= sx && ty >= sy) {
        if (tx === sx && ty === sy) return true;
        if (tx > ty) {
            tx -= Math.max(1, Math.floor((tx - sx) / ty)) * ty;
        } else {
            ty -= Math.max(1, Math.floor((ty - sy) / tx)) * tx;
        }
    }
    return sx === tx && sy <= ty && (ty - sy) % sx === 0 || sy === ty && sx <= tx && (tx - sx) % sy === 0;
};