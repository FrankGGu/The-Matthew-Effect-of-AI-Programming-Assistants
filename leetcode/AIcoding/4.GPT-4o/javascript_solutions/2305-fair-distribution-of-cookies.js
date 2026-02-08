var distributeCookies = function(cookies, k) {
    let n = cookies.length;
    let ans = Infinity;
    let distribution = new Array(k).fill(0);

    function backtrack(index) {
        if (index === n) {
            ans = Math.min(ans, Math.max(...distribution));
            return;
        }
        for (let i = 0; i < k; i++) {
            distribution[i] += cookies[index];
            backtrack(index + 1);
            distribution[i] -= cookies[index];
            if (distribution[i] === 0) break; // optimization to avoid duplicate distributions
        }
    }

    backtrack(0);
    return ans;
};