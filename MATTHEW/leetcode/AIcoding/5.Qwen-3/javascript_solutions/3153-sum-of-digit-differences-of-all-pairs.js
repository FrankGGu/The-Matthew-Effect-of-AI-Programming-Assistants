function sumOfDigitDifferences(nums) {
    const MOD = 10**9 + 7;
    const n = nums.length;
    const count = Array(10).fill(0);
    const result = 0;

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        const digits = [];
        let temp = num;
        while (temp > 0) {
            digits.push(temp % 10);
            temp = Math.floor(temp / 10);
        }
        for (let j = 0; j < digits.length; j++) {
            count[digits[j]]++;
        }
    }

    for (let i = 0; i < 10; i++) {
        if (count[i] > 1) {
            result += (count[i] * (count[i] - 1)) / 2;
        }
    }

    return result % MOD;
}