var distributeCookies = function(cookies, k) {
    let distribution = new Array(k).fill(0);
    let minUnfairness = Infinity;

    function backtrack(index) {
        if (index === cookies.length) {
            minUnfairness = Math.min(minUnfairness, Math.max(...distribution));
            return;
        }

        for (let i = 0; i < k; i++) {
            distribution[i] += cookies[index];
            backtrack(index + 1);
            distribution[i] -= cookies[index];
        }
    }

    backtrack(0);
    return minUnfairness;
};