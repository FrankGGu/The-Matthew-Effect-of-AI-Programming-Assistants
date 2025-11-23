var createSortedArray = function(instructions) {
    const MOD = 1e9 + 7;
    const maxVal = Math.max(...instructions);
    const count = new Array(maxVal + 1).fill(0);
    let result = 0;

    for (let num of instructions) {
        let left = 0, right = num - 1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (count[mid] < num) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result = (result + left) % MOD;
        count[num]++;
    }

    return result;
};