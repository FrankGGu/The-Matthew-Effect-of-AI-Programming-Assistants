var countTheNumberofWinningSequences = function(A, K) {
    const n = A.length;
    A.sort((a, b) => a - b);
    let ans = 0;
    const used = new Array(n).fill(false);

    function backtrack(curr, count) {
        if (count === K) {
            ans++;
            return;
        }

        for (let i = 0; i < n; i++) {
            if (used[i]) continue;
            if (i > 0 && A[i] === A[i - 1] && !used[i - 1]) continue;

            used[i] = true;
            backtrack(curr + A[i], count + 1);
            used[i] = false;
        }
    }

    backtrack(0, 0);
    return ans;
};