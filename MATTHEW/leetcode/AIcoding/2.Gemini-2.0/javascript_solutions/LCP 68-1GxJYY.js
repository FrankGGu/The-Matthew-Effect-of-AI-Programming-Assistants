var maximumBeauty = function(flowers, newFlowers, target) {
    flowers.sort((a, b) => a - b);
    let n = flowers.length;
    let l = 0, r = 2 * 10**9;
    let ans = 0;

    while (l <= r) {
        let mid = Math.floor((l + r) / 2);
        let cost = 0;
        for (let i = 0; i < n; i++) {
            if (flowers[i] < mid) {
                cost += Math.max(0, mid - flowers[i]);
            }
        }

        if (cost <= newFlowers) {
            ans = mid;
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }

    let beauty = 0;
    let count = 0;
    for (let i = 0; i < n; i++) {
        if (ans >= target) {
            beauty += target;
            count++;
        }
        else if (flowers[i] >= target){
            beauty += target;
            count++;
        }
        else if (flowers[i] >= ans){
            beauty += ans;
            count++;
        }
        else {
            beauty += Math.min(target, flowers[i]);
        }
    }

    let remaining = newFlowers;
    for (let i = 0; i < n; i++) {
        if(flowers[i] < ans){
            remaining -= Math.max(0, ans - flowers[i]);
        }
    }

    if (ans >= target) {
        return target;
    }

    if(ans < target && remaining >= (n - count) * (target - ans)){
        beauty += (n-count) * target;
        remaining -= (n - count) * (target - ans);
    }
    else if(ans < target && remaining > 0) {
        beauty += Math.floor(remaining / (n - count)) * (n - count);
        remaining = 0;
    }

    let res = 0;
    for (let i = 0; i < n; i++) {
        if(ans >= target || flowers[i] >= target){
            res += target;
        }
        else{
            res += Math.min(target, ans);
        }
    }

    return Math.min(target, ans);
};