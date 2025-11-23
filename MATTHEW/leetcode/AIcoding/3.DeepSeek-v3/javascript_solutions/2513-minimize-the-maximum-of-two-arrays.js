var minimizeSet = function(divisor1, divisor2, uniqueCnt1, uniqueCnt2) {
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const lcm = (a, b) => (a * b) / gcd(a, b);

    let left = 1, right = 2e9;
    let answer = right;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);

        const notDivisibleBy1 = Math.floor(mid / divisor1) * divisor1;
        const cnt1 = mid - notDivisibleBy1;

        const notDivisibleBy2 = Math.floor(mid / divisor2) * divisor2;
        const cnt2 = mid - notDivisibleBy2;

        const lcmVal = lcm(divisor1, divisor2);
        const notDivisibleByBoth = Math.floor(mid / lcmVal) * lcmVal;
        const common = mid - notDivisibleByBoth;

        const availableFor1 = cnt1 - common;
        const availableFor2 = cnt2 - common;
        const availableCommon = mid - (cnt1 + cnt2 - common);

        const needed1 = Math.max(0, uniqueCnt1 - availableFor1);
        const needed2 = Math.max(0, uniqueCnt2 - availableFor2);

        if (needed1 + needed2 <= availableCommon) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
};