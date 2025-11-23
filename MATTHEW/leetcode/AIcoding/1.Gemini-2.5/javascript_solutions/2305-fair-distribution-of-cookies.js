var distributeCookies = function(cookies, k) {
    let minUnfairness = Infinity;
    const childLoads = new Array(k).fill(0);

    cookies.sort((a, b) => b - a);

    function dfs(cookieIndex) {
        if (cookieIndex === cookies.length) {
            let currentMaxLoad = 0;
            for (let i = 0; i < k; i++) {
                currentMaxLoad = Math.max(currentMaxLoad, childLoads[i]);
            }
            minUnfairness = Math.min(minUnfairness, currentMaxLoad);
            return;
        }

        for (let i = 0; i < k; i++) {
            if (childLoads[i] + cookies[cookieIndex] >= minUnfairness) {
                continue;
            }

            if (childLoads[i] === 0) {
                let hasPreviousEmpty = false;
                for (let j = 0; j < i; j++) {
                    if (childLoads[j] === 0) {
                        hasPreviousEmpty = true;
                        break;
                    }
                }
                if (hasPreviousEmpty) {
                    continue;
                }
            }

            childLoads[i] += cookies[cookieIndex];
            dfs(cookieIndex + 1);
            childLoads[i] -= cookies[cookieIndex];
        }
    }

    dfs(0);

    return minUnfairness;
};