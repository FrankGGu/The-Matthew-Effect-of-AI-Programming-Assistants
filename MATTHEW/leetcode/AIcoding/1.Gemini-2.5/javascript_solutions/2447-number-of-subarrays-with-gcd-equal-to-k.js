var subarrayGCD = function(nums, k) {
    let count = 0;
    const n = nums.length;

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    for (let i = 0; i < n; i++) {
        let currentGCD = 0;
        for (let j = i; j < n; j++) {
            if (nums[j] % k !== 0) {
                break;
            }

            if (currentGCD === 0) {
                currentGCD = nums[j];
            } else {
                currentGCD = gcd(currentGCD, nums[j]);
            }

            if (currentGCD === k) {
                count++;
            }

            if (currentGCD < k) {
                break;
            }
        }
    }

    return count;
};