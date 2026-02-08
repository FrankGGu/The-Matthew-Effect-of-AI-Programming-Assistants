function whacAMole(moles) {
    if (moles.length === 0) {
        return 0;
    }

    moles.sort((a, b) => a[2] - b[2]);

    const n = moles.length;
    const dp = new Array(n).fill(1);
    let maxMolesHit = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const moleJ = moles[j];
            const moleI = moles[i];

            const timeDiff = moleI[2] - moleJ[2];
            const distNeeded = Math.abs(moleI[0] - moleJ[0]) + Math.abs(moleI[1] - moleJ[1]);

            if (timeDiff >= distNeeded) {
                dp[i] = Math.max(dp[i], 1 + dp[j]);
            }
        }
        maxMolesHit = Math.max(maxMolesHit, dp[i]);
    }

    return maxMolesHit;
}