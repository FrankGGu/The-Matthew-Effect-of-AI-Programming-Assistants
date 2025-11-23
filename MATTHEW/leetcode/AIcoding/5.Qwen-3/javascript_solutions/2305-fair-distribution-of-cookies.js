function distributeCookies(cookies, k) {
    let minUnfairness = Infinity;

    function backtrack(index, distribution) {
        if (index === cookies.length) {
            let max = 0;
            for (let i = 0; i < k; i++) {
                max = Math.max(max, distribution[i]);
            }
            minUnfairness = Math.min(minUnfairness, max);
            return;
        }

        for (let i = 0; i < k; i++) {
            if (distribution[i] + cookies[index] >= minUnfairness) continue;
            distribution[i] += cookies[index];
            backtrack(index + 1, distribution);
            distribution[i] -= cookies[index];
        }
    }

    backtrack(0, new Array(k).fill(0));
    return minUnfairness;
}