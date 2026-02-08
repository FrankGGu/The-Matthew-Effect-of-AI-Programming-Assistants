var stoneGameIX = function(nums) {
    let cnt0 = 0, cnt1 = 0, cnt2 = 0;
    for (const num of nums) {
        if (num % 3 === 0) {
            cnt0++;
        } else if (num % 3 === 1) {
            cnt1++;
        } else {
            cnt2++;
        }
    }

    if (cnt0 % 2 === 0) {
        return Math.min(cnt1, cnt2) > 0;
    } else {
        return Math.abs(cnt1 - cnt2) > 2;
    }
};