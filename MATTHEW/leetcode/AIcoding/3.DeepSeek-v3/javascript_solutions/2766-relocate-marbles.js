var relocateMarbles = function(nums, moveFrom, moveTo) {
    const marbleSet = new Set(nums);

    for (let i = 0; i < moveFrom.length; i++) {
        const from = moveFrom[i];
        const to = moveTo[i];

        if (marbleSet.has(from)) {
            marbleSet.delete(from);
            marbleSet.add(to);
        }
    }

    return Array.from(marbleSet).sort((a, b) => a - b);
};