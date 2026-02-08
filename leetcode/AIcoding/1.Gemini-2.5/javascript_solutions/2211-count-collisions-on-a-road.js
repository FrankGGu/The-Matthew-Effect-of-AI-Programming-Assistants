var countCollisions = function(directions) {
    let trimmed = directions.replace(/^L+/, '').replace(/R+$/, '');

    let collisions = 0;
    for (let i = 0; i < trimmed.length; i++) {
        if (trimmed[i] === 'L' || trimmed[i] === 'R') {
            collisions++;
        }
    }

    return collisions;
};