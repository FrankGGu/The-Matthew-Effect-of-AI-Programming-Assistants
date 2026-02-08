var kSimilarity = function(s1, s2) {
    let queue = [[s1, 0]];
    let visited = new Set();
    visited.add(s1);
    let steps = 0;

    while (queue.length > 0) {
        let size = queue.length;
        for (let i = 0; i < size; i++) {
            let [curr, currSteps] = queue.shift();

            if (curr === s2) {
                return steps;
            }

            for (let j = 0; j < curr.length; j++) {
                if (curr[j] !== s2[j]) {
                    for (let l = j + 1; l < curr.length; l++) {
                        if (curr[l] === s2[j]) {
                            let next = curr.substring(0, j) + curr[l] + curr.substring(j + 1, l) + curr[j] + curr.substring(l + 1);
                            if (!visited.has(next)) {
                                queue.push([next, currSteps + 1]);
                                visited.add(next);
                            }
                        }
                    }
                    break;
                }
            }
        }
        steps++;
    }

    return -1;
};

var minimumChanges = function(s, k) {
    const n = s.length;
    const cost = Array(n).fill(null).map(() => Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let l = i, r = j;
            while (l < r) {
                if (s[l] !== s[r]) {
                    cost[i][j]++;
                }
                l++;
                r--;
            }
        }
    }

    const dp = Array(k + 1).fill(null).map(() => Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= n; j++) {
            for (let l = i - 1; l < j; l++) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][l] + cost[l][j - 1]);
            }
        }
    }

    return dp[k][n];
};