var subarrayLCM = function(nums, k) {
    let count = 0;
    const n = nums.length;

    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    function lcm(a, b) {
        return (a / gcd(a, b)) * b;
    }

    for (let i = 0; i < n; i++) {
        let currentLCM = 1;
        for (let j = i; j < n; j++) {
            let num = nums[j];

            if (num > k) {
                currentLCM = k + 1;
                break;
            }

            if (k % num !== 0) {
                currentLCM = k + 1;
                break;
            }

            currentLCM = lcm(currentLCM, num);

            if (currentLCM > k) {
                break;
            }

            if (currentLCM === k) {
                count++;
            }
        }
    }

    return count;
};