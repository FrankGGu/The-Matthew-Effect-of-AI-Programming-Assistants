function bestTeamWinners(photos) {
    photos.sort((a, b) => a[0] - b[0]);
    const dp = new Array(photos.length).fill(1);
    for (let i = 0; i < photos.length; i++) {
        for (let j = 0; j < i; j++) {
            if (photos[i][1] >= photos[j][1]) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }
    return Math.max(...dp);
}