var numOfSubarrays = function(arr) {
    let mod = 1e9 + 7;
    let odd = 0, even = 1; // even starts with 1 to account for the initial sum of 0
    let sum = 0, res = 0;
    for (let num of arr) {
        sum += num;
        if (sum % 2 === 1) {
            res += even;
            odd++;
        } else {
            res += odd;
            even++;
        }
        res %= mod;
    }
    return res;
};