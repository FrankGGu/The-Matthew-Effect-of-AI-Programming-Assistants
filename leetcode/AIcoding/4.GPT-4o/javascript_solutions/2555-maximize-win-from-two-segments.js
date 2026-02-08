function maximizeWin(A, k) {
    A.sort((a, b) => a - b);
    let maxWins = 0;
    let j = 0;
    const n = A.length;

    for (let i = 0; i < n; i++) {
        while (j < n && A[j] - A[i] <= k) {
            j++;
        }
        maxWins = Math.max(maxWins, j - i);
    }

    for (let i = 0; i < n; i++) {
        let leftWins = 0;
        let j = i;

        while (j < n && A[j] - A[i] <= k) {
            leftWins++;
            j++;
        }

        let rightWins = 0;
        j = i + leftWins;

        while (j < n && A[j] - A[i + leftWins] <= k) {
            rightWins++;
            j++;
        }

        maxWins = Math.max(maxWins, leftWins + rightWins);
    }

    return maxWins;
}