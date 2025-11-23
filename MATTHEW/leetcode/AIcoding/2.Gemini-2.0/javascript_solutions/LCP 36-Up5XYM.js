var maxGroupNumber = function(piles, cardsPerGroup, seq) {
    const n = piles.length;
    const dp = new Array(1 << n).fill(-1);

    function solve(mask) {
        if (mask === (1 << n) - 1) {
            return 0;
        }

        if (dp[mask] !== -1) {
            return dp[mask];
        }

        let ans = 0;
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                let sum = 0;
                let count = 0;
                let newMask = mask | (1 << i);
                sum += piles[i];
                count++;

                for (let j = i + 1; j < n; j++) {
                    if ((mask & (1 << j)) === 0 && count < cardsPerGroup) {
                        newMask |= (1 << j);
                        sum += piles[j];
                        count++;
                    }
                }

                if (count === cardsPerGroup && sum >= seq) {
                    ans = Math.max(ans, 1 + solve(newMask));
                } else if (count === cardsPerGroup) {
                    ans = Math.max(ans, solve(newMask));
                }
            }
        }
        if(ans === 0){
            let newMask = mask;
            let count = 0;
            for(let i = 0; i < n; i++){
                if ((mask & (1 << i)) === 0 && count < cardsPerGroup){
                    newMask |= (1 << i);
                    count++;
                }
            }

            if(count === cardsPerGroup){
                ans = Math.max(ans, solve(newMask));
            }
        }
        dp[mask] = ans;
        return ans;
    }

    return solve(0);
};