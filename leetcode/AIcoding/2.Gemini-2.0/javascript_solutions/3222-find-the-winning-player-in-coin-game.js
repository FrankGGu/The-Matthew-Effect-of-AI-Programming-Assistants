var findTheWinner = function(a) {
    let n = a.length;
    let dp = new Array(n).fill(0);

    for(let i = 1; i < n; i++){
        if(a[i] > a[i-1]){
            dp[i] = dp[i-1] + 1;
        }
    }

    let ans1 = 0, ans2 = 0;
    for(let i = 0; i < n; i++){
        if(dp[i] >= (n + 1) / 2)
            return 2;
    }

    a = a.reverse();

    dp = new Array(n).fill(0);

    for(let i = 1; i < n; i++){
        if(a[i] > a[i-1]){
            dp[i] = dp[i-1] + 1;
        }
    }

    for(let i = 0; i < n; i++){
        if(dp[i] >= (n + 1) / 2)
            return 1;
    }

    return 0;
};