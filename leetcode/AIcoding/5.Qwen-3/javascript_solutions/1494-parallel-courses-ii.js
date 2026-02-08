function minNumberOfSemesters(n, relations) {
    const graph = Array.from({ length: n }, () => []);
    const inDegree = Array(n).fill(0);

    for (const [prereq, course] of relations) {
        graph[prereq].push(course);
        inDegree[course]++;
    }

    const dp = Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        const available = [];
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0 && inDegree[i] === 0) {
                available.push(i);
            }
        }

        let submask = (1 << available.length) - 1;
        while (submask > 0) {
            let newMask = mask;
            for (let i = 0; i < available.length; i++) {
                if ((submask >> i) & 1) {
                    newMask |= (1 << available[i]);
                }
            }

            let newInDegree = [...inDegree];
            for (let i = 0; i < available.length; i++) {
                if ((submask >> i) & 1) {
                    for (const course of graph[available[i]]) {
                        newInDegree[course]--;
                    }
                }
            }

            dp[newMask] = Math.min(dp[newMask], dp[mask] + 1);

            submask = (submask - 1) & (1 << available.length) - 1;
        }
    }

    return dp[(1 << n) - 1];
}