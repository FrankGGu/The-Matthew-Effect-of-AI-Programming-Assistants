var maxProduct = function(s) {
    const n = s.length;

    function longestPalindromeSubstring(str) {
        const n = str.length;
        const dp = Array(n).fill(null).map(() => Array(n).fill(false));
        let maxLength = 1;

        for (let i = 0; i < n; i++) {
            dp[i][i] = true;
        }

        for (let i = 0; i < n - 1; i++) {
            if (str[i] === str[i + 1]) {
                dp[i][i + 1] = true;
                maxLength = 2;
            }
        }

        for (let k = 3; k <= n; k++) {
            for (let i = 0; i <= n - k; i++) {
                let j = i + k - 1;
                if (str[i] === str[j] && dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                    maxLength = k;
                }
            }
        }

        const lengths = Array(n).fill(0);
        for (let i = 0; i < n; i++) {
            for (let j = i; j < n; j++) {
                if (dp[i][j]) {
                    lengths[i] = Math.max(lengths[i], j - i + 1);
                }
            }
        }
        return lengths;
    }

    const leftLengths = longestPalindromeSubstring(s);
    const rightLengths = longestPalindromeSubstring(s.split("").reverse().join("")).reverse();

    let maxProd = 0;
    for (let i = 0; i < n - 1; i++) {
        maxProd = Math.max(maxProd, leftLengths[0] * rightLengths[i + 1]);
        maxProd = Math.max(maxProd, leftLengths[i] * rightLengths[i+1]);
    }

    for(let i = 0; i < n; i++){
        for(let j = i+1; j < n; j++){
            maxProd = Math.max(maxProd, leftLengths[0]*rightLengths[j]);
        }
    }
    let maxL = 0;
    for(let i = 0; i < n; i++){
        maxL = Math.max(maxL, leftLengths[i]);
    }
    let maxR = 0;
    for(let i = 0; i < n; i++){
        maxR = Math.max(maxR, rightLengths[i]);
    }
    maxProd = Math.max(maxProd, maxL * maxR);

    let max1 = 0
    for(let i = 0; i < n; i++){
        max1 = Math.max(max1, leftLengths[i])
    }

    let max2 = 0
    for(let i = 0; i < n; i++){
        max2 = Math.max(max2, rightLengths[i])
    }
    maxProd = Math.max(maxProd, max1*max2)

    let ans = 0;
    for(let i = 0; i < n-1; i++){
        ans = Math.max(ans, leftLengths[i]* rightLengths[i+1])
    }

    let maxLeft = 0
    for(let i = 0; i < n; i++){
        maxLeft = Math.max(maxLeft, leftLengths[i])
    }
    let maxRight = 0
    for(let i = 0; i < n; i++){
        maxRight = Math.max(maxRight, rightLengths[i])
    }

    return maxLeft * maxRight;
};