var escapeGhosts = function(ghosts, target) {
    const [tx, ty] = target;
    const distToTarget = Math.abs(tx) + Math.abs(ty);

    for (let [gx, gy] of ghosts) {
        const distToGhost = Math.abs(gx - tx) + Math.abs(gy - ty);
        if (distToGhost <= distToTarget) {
            return false;
        }
    }

    return true;
};