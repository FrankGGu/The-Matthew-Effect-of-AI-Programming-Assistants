var escapeGhosts = function(ghosts, target) {
    const myDistance = Math.abs(target[0]) + Math.abs(target[1]);

    for (const ghost of ghosts) {
        const ghostDistance = Math.abs(ghost[0] - target[0]) + Math.abs(ghost[1] - target[1]);
        if (ghostDistance <= myDistance) {
            return false;
        }
    }

    return true;
};