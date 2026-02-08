var threeSumMulti = function(arr, target) {
    const MOD = 1e9 + 7;
    let count = 0;
    const freq = {};

    for (let num of arr) {
        freq[num] = (freq[num] || 0) + 1;
    }

    const uniqueNums = Object.keys(freq).map(Number).sort((a, b) => a - b);

    for (let i = 0; i < uniqueNums.length; i++) {
        let x = uniqueNums[i];
        let newTarget = target - x;
        let left = i;
        let right = uniqueNums.length - 1;

        while (left <= right) {
            let y = uniqueNums[left];
            let z = uniqueNums[right];

            if (y + z < newTarget) {
                left++;
            } else if (y + z > newTarget) {
                right--;
            } else {
                if (i < left && left < right) {
                    count += freq[x] * freq[y] * freq[z];
                } else if (i === left && left < right) {
                    count += freq[x] * (freq[x] - 1) / 2 * freq[z];
                } else if (i < left && left === right) {
                    count += freq[x] * freq[y] * (freq[y] - 1) / 2;
                } else {
                    count += freq[x] * (freq[x] - 1) * (freq[x] - 2) / 6;
                }
                count %= MOD;
                left++;
                right--;
            }
        }
    }

    return count;
};