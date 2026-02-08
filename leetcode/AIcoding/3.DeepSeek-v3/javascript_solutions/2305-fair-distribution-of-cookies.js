var distributeCookies = function(cookies, k) {
    let minUnfairness = Infinity;
    const distribution = new Array(k).fill(0);

    function backtrack(index) {
        if (index === cookies.length) {
            const currentMax = Math.max(...distribution);
            minUnfairness = Math.min(minUnfairness, currentMax);
            return;
        }

        for (let i = 0; i < k; i++) {
            distribution[i] += cookies[index];
            if (distribution[i] < minUnfairness) {
                backtrack(index + 1);
            }
            distribution[i] -= cookies[index];
            if (distribution[i] === 0) break;
        }
    }

    backtrack(0);
    return minUnfairness;
};