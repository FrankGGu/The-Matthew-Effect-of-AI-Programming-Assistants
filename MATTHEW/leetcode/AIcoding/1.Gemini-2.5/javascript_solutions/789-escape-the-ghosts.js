var escapeGhosts = function(ghosts, target) {
    const playerDist = Math.abs(target[0]) + Math.abs(target[1]);

    for (let i = 0; i < ghosts.length; i++) {
        const ghostDist = Math.abs(ghosts[i][0] - target[0]) + Math.abs(ghosts[i][1] - target[1]);
        if (ghostDist <= playerDist) {
            return false;
        }
    }

    return true;
};