var stoneGameIX = function(stones) {
    let cnt0 = 0, cnt1 = 0, cnt2 = 0;
    for (let stone of stones) {
        if (stone % 3 === 0) {
            cnt0++;
        } else if (stone % 3 === 1) {
            cnt1++;
        } else {
            cnt2++;
        }
    }

    if (cnt0 % 2 === 0) {
        return cnt1 >= 1 && cnt2 >= 1;
    } else {
        return Math.abs(cnt1 - cnt2) > 2;
    }
};