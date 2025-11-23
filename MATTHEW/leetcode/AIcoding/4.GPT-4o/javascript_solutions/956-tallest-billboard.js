var tallestBillboard = function(rods) {
    const dp = new Map();
    dp.set(0, 0);

    for (const rod of rods) {
        const current = Array.from(dp);
        for (const [diff, height] of current) {
            dp.set(diff + rod, Math.max(dp.get(diff + rod) || 0, height));
            dp.set(diff - rod, Math.max(dp.get(diff - rod) || 0, height + (diff >= rod ? 0 : -Infinity)));
            dp.set(diff, Math.max(dp.get(diff) || 0, height + (diff === 0 ? 0 : 0)));
        }
    }

    return dp.get(0) || 0;
};