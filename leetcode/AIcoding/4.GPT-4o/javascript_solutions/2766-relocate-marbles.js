var relocateMarbles = function(marbles, moveFrom, moveTo) {
    const positions = new Set(marbles);
    for (let i = 0; i < moveFrom.length; i++) {
        positions.delete(moveFrom[i]);
        positions.add(moveTo[i]);
    }
    return Array.from(positions).sort((a, b) => a - b);
};