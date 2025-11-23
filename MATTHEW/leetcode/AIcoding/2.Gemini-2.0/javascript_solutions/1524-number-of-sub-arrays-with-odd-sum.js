var numOfSubarrays = function(arr) {
    let even = 1;
    let odd = 0;
    let res = 0;
    const MOD = 10**9 + 7;

    for (let num of arr) {
        if (num % 2 === 0) {
            even++;
        } else {
            let temp = even;
            even = odd;
            odd = temp + 1;
        }
        even %= MOD;
        odd %= MOD;
        res = (res + odd) % MOD;
    }

    return res;
};