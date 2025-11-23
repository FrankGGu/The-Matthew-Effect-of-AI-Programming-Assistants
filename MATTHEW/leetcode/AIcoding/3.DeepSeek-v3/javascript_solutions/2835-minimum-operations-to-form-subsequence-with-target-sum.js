var minOperations = function(nums, target) {
    let sum = nums.reduce((a, b) => a + b, 0);
    if (sum < target) return -1;

    let freq = Array(32).fill(0);
    for (let num of nums) {
        let power = Math.log2(num);
        freq[power]++;
    }

    let res = 0;
    for (let i = 0; i < 31; i++) {
        let bit = (target >> i) & 1;
        if (bit) {
            if (freq[i] > 0) {
                freq[i]--;
            } else {
                let j = i + 1;
                while (j < 31 && freq[j] === 0) {
                    j++;
                }
                if (j === 31) return -1;
                freq[j]--;
                for (let k = i; k < j; k++) {
                    freq[k]++;
                }
                res += j - i;
            }
        }
        freq[i + 1] += Math.floor(freq[i] / 2);
    }
    return res;
};