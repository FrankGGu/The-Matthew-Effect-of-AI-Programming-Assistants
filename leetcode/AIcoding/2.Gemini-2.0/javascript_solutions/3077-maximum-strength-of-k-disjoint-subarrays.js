var maxStrength = function(nums, k) {
    nums.sort((a, b) => a - b);
    let neg = [];
    let pos = [];
    let zero = 0;
    for (let num of nums) {
        if (num < 0) neg.push(num);
        else if (num > 0) pos.push(num);
        else zero++;
    }

    if (k === 1) {
        if (pos.length === 0 && neg.length === 0) return 0;
        let max = -Infinity;
        for (let num of nums) {
            max = Math.max(max, num);
        }
        return max;
    }

    if (pos.length === 0 && neg.length % 2 !== 0 && k === nums.length) return 0;
    if (pos.length === 0 && neg.length === nums.length && neg.length % 2 !== 0 && k <= neg.length && zero > 0) return 0;

    let ans = 1;
    let left = 0;
    let right = neg.length - 1;

    while (k > 0) {
        if (pos.length > 0 && (neg.length < 2 || pos[pos.length - 1] * (pos.length > 1 ? pos[pos.length - 2] : 1) > neg[left] * neg[right])) {
            ans *= pos[pos.length - 1];
            pos.pop();
            k--;
        } else if (neg.length >= 2) {
            ans *= neg[left] * neg[right];
            left++;
            right--;
            neg.length -= 2;
            k--;
        } else if (pos.length > 0) {
            ans *= pos[pos.length-1];
            pos.pop();
            k--;

        } else if (neg.length > 0){
            ans *= neg[right];
            right--;
            neg.length--;
            k--;

        } else {
            if (k > 0) return 0;
        }
    }

    return ans;
};