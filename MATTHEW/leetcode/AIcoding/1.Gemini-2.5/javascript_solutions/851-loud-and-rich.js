var loudAndRich = function(quiet, richer) {
    const n = quiet.length;

    const revAdj = Array(n).fill(0).map(() => []);
    for (const [u, v] of richer) {
        revAdj[v].push(u);
    }

    const memo = Array(n).fill(-1);

    const dfs = (person) => {
        if (memo[person] !== -1) {
            return memo[person];
        }

        let quietestPersonIndex = person;

        for (const richerPerson of revAdj[person]) {
            const candidateQuietestIndex = dfs(richerPerson);

            if (quiet[candidateQuietestIndex] < quiet[quietestPersonIndex]) {
                quietestPersonIndex = candidateQuietestIndex;
            }
        }

        memo[person] = quietestPersonIndex;
        return quietestPersonIndex;
    };

    const answer = Array(n);

    for (let i = 0; i < n; i++) {
        answer[i] = dfs(i);
    }

    return answer;
};