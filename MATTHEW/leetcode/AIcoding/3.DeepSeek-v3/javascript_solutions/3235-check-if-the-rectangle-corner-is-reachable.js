var isReachable = function(targetX, targetY) {
    while (targetX > 1 || targetY > 1) {
        if (targetX > targetY) {
            if (targetY === 0) return false;
            targetX %= targetY;
        } else {
            if (targetX === 0) return false;
            targetY %= targetX;
        }
    }
    return true;
};