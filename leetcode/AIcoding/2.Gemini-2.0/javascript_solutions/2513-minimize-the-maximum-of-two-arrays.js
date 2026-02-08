var minimizeSet = function(n, divisor1, divisor2, uniqueCnt1, uniqueCnt2) {
    let low = 1;
    let high = 2 * n;
    let ans = high;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let cnt1 = mid - Math.floor(mid / divisor1);
        let cnt2 = mid - Math.floor(mid / divisor2);
        let both = mid - Math.floor(mid / divisor1) - Math.floor(mid / divisor2) + Math.floor(mid / (divisor1 * divisor2 / gcd(divisor1, divisor2)));

        if (cnt1 >= uniqueCnt1 && cnt2 >= uniqueCnt2 && both >= uniqueCnt1 + uniqueCnt2) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};