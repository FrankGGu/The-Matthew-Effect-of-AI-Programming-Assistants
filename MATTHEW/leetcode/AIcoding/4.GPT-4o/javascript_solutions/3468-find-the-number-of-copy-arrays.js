var countCopyArrays = function(nums) {
    const mod = 1e9 + 7;
    const n = nums.length;
    let answer = 0;

    const count = new Array(n + 1).fill(0);
    count[0] = 1;

    for (let num of nums) {
        for (let j = n; j >= 1; j--) {
            if (j <= num) {
                count[j] = (count[j] + count[j - 1]) % mod;
            }
        }
    }

    for (let j = 0; j <= n; j++) {
        answer = (answer + count[j]) % mod;
    }

    return answer;
};