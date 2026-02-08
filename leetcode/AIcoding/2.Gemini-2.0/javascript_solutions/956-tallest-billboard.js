var tallestBillboard = function(rods) {
    const sum = rods.reduce((acc, rod) => acc + rod, 0);
    const dp = new Map();
    dp.set(0, 0);

    for (const rod of rods) {
        const nextDp = new Map(dp);
        for (const [diff, height] of dp) {
            // Case 1: Put the rod on the taller support
            nextDp.set(diff + rod, Math.max(nextDp.get(diff + rod) || 0, height));

            // Case 2: Put the rod on the shorter support
            nextDp.set(Math.abs(diff - rod), Math.max(nextDp.get(Math.abs(diff - rod)) || 0, height + Math.min(diff, rod)));

            // Case 3: Don't use the rod
            // Do nothing, already in nextDp
        }
        dp = nextDp;
    }

    return dp.get(0) || 0;
};