var relocateMarbles = function(nums, moveFrom, moveTo) {
    const marblePositions = new Set(nums);

    for (let i = 0; i < moveFrom.length; i++) {
        const from = moveFrom[i];
        const to = moveTo[i];

        if (marblePositions.has(from)) {
            marblePositions.delete(from);
            marblePositions.add(to);
        }
    }

    const result = Array.from(marblePositions);
    result.sort((a, b) => a - b);

    return result;
};