var minimalKSum = function(nums, k) {
    nums.sort((a, b) => a - b);

    let totalSum = 0n;
    let currentInteger = 1n;
    let kBig = BigInt(k);

    for (let i = 0; i < nums.length; i++) {
        const num = BigInt(nums[i]);

        if (kBig === 0n) {
            break;
        }

        // Skip duplicate numbers in nums
        if (i > 0 && BigInt(nums[i]) === BigInt(nums[i-1])) {
            continue;
        }

        // If there's a gap between currentInteger and num, fill it
        // The gap includes integers from currentInteger up to num - 1
        if (currentInteger < num) {
            const countInGap = num - currentInteger;
            const countToAdd = countInGap < kBig ? countInGap : kBig; // Equivalent to Math.min(countInGap, kBig)

            // Sum of arithmetic series: (first + last) * count / 2
            // First term: currentInteger
            // Last term: currentInteger + countToAdd - 1n
            totalSum += (currentInteger + (currentInteger + countToAdd - 1n)) * countToAdd / 2n;
            kBig -= countToAdd;
            currentInteger += countToAdd;
        }

        if (kBig === 0n) {
            break;
        }

        // After considering the gap (if any) before 'num',
        // 'num' itself cannot be added because it's already in the array.
        // So, the next integer we consider must be at least 'num + 1'.
        // We use Math.max to ensure currentInteger never decreases,
        // as it should always represent the smallest available integer.
        currentInteger = currentInteger > num + 1n ? currentInteger : num + 1n; // Equivalent to Math.max(currentInteger, num + 1n)
    }

    // If kBig is still greater than 0, add the remaining kBig integers
    // These will be consecutive integers starting from currentInteger
    if (kBig > 0n) {
        // First term: currentInteger
        // Last term: currentInteger + kBig - 1n
        totalSum += (currentInteger + (currentInteger + kBig - 1n)) * kBig / 2n;
    }

    return Number(totalSum);
};