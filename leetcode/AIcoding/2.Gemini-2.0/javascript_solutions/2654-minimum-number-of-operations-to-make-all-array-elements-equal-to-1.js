var minOperations = function(nums) {
    let countOne = 0;
    for (let num of nums) {
        if (num === 1) {
            countOne++;
        }
    }

    if (countOne > 0) {
        return nums.length - countOne;
    }

    let minOps = Infinity;
    for (let i = 0; i < nums.length; i++) {
        let gcdVal = nums[i];
        for (let j = i + 1; j < nums.length; j++) {
            gcdVal = gcd(gcdVal, nums[j]);
            if (gcdVal === 1) {
                minOps = Math.min(minOps, j - i);
                break;
            }
        }
    }

    if (minOps === Infinity) {
        return -1;
    }

    return minOps + nums.length - 1;

    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};