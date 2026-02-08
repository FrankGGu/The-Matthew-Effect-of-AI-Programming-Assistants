var countBeautifulPairs = function(nums) {
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (gcd(nums[i], nums[j]) === 1) {
                count++;
            }
        }
    }

    return count;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}