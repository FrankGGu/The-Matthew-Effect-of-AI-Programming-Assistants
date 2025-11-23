var relocateMarbles = function(nums, moveFrom, moveTo) {
    const marbles = new Set(nums);

    for (let i = 0; i < moveFrom.length; i++) {
        if (marbles.has(moveFrom[i])) {
            marbles.delete(moveFrom[i]);
            marbles.add(moveTo[i]);
        }
    }

    return Array.from(marbles).sort((a, b) => a - b);
};