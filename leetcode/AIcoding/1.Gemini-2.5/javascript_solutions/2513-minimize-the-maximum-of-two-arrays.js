const gcd = (a, b) => {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
};

const lcm = (a, b) => {
    if (a === 0 || b === 0) return 0;
    const common = gcd(a, b);
    return (a / common) * b;
};

var minimizeTheMaximumOfTwoArrays = function(divisor1, divisor2, distinctCnt1, distinctCnt2) {
    const check = (mid) => {
        const common_lcm = lcm(divisor1, divisor2);

        // Count of numbers from 1 to mid that are NOT divisible by divisor1 BUT ARE divisible by divisor2.
        // These numbers can only be placed in arr1.
        const can_be_in_arr1_only = Math.floor(mid / divisor2) - Math.floor(mid / common_lcm);

        // Count of numbers from 1 to mid that are NOT divisible by divisor2 BUT ARE divisible by divisor1.
        // These numbers can only be placed in arr2.
        const can_be_in_arr2_only = Math.floor(mid / divisor1) - Math.floor(mid / common_lcm);

        // Count of numbers from 1 to mid that are NOT divisible by divisor1 AND NOT divisible by divisor2.
        // These numbers can be placed in either arr1 or arr2.
        const can_be_in_both = mid - (
            Math.floor(mid / divisor1) +
            Math.floor(mid / divisor2) -
            Math.floor(mid / common_lcm)
        );

        // Calculate remaining distinct counts needed for arr1 and arr2
        // after fulfilling as much as possible with "only" elements.
        const remaining_c1 = Math.max(0, distinctCnt1 - can_be_in_arr1_only);
        const remaining_c2 = Math.max(0, distinctCnt2 - can_be_in_arr2_only);

        // Check if the numbers that can be in "both" arrays are sufficient
        // to meet the combined remaining needs of both arrays.
        return can_be_in_both >= (remaining_c1 + remaining_c2);
    };

    let low = 1;
    // A safe upper bound for the binary search.
    // In the worst case, if divisors are small (e.g., 2 and 3),
    // we might need roughly 3 times the total distinct count.
    // Max distinctCnt1 + distinctCnt2 is 2 * 10^9. So 3 * 2 * 10^9 = 6 * 10^9.
    // Using 10^10 to be absolutely safe, as JavaScript numbers handle up to 9 * 10^15 without precision loss.
    let high = 10**10; 

    let ans = high;

    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};