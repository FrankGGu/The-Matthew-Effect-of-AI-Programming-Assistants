var kIncreasing = function(arr, k) {
    let res = 0;
    for (let i = 0; i < k; i++) {
        let sub = [];
        for (let j = i; j < arr.length; j += k) {
            sub.push(arr[j]);
        }
        res += sub.length - lengthOfLIS(sub);
    }
    return res;
};

function lengthOfLIS(nums) {
    let tails = [];
    for (let num of nums) {
        let left = 0, right = tails.length;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (tails[mid] > num) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        if (left === tails.length) {
            tails.push(num);
        } else {
            tails[left] = num;
        }
    }
    return tails.length;
}