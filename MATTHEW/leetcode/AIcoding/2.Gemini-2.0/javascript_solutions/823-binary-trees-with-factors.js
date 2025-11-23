var numFactoredBinaryTrees = function(arr) {
    const MOD = 10**9 + 7;
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const dp = new Map();

    for (let i = 0; i < n; i++) {
        dp.set(arr[i], 1);
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (arr[i] % arr[j] === 0) {
                const factor1 = arr[j];
                const factor2 = arr[i] / arr[j];
                if (dp.has(factor2)) {
                    let count = (dp.get(arr[i]) || 0);
                    if(factor1 === factor2){
                        count = (count + (dp.get(factor1) * dp.get(factor2)) % MOD) % MOD;
                    }else{
                        count = (count + (dp.get(factor1) * dp.get(factor2) * 2) % MOD) % MOD;
                    }

                    dp.set(arr[i], count);
                }
            }
        }
    }

    let result = 0;
    for (const count of dp.values()) {
        result = (result + count) % MOD;
    }

    return result;
};