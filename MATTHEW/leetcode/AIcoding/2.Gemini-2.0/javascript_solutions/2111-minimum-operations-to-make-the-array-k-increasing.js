var kIncreasing = function(arr, k) {
    let n = arr.length;
    let ans = 0;

    for (let i = 0; i < k; i++) {
        let sub = [];
        for (let j = i; j < n; j += k) {
            sub.push(arr[j]);
        }

        let tail = [];
        for (let num of sub) {
            if (tail.length === 0 || num >= tail[tail.length - 1]) {
                tail.push(num);
            } else {
                let l = 0, r = tail.length - 1;
                while (l < r) {
                    let mid = Math.floor((l + r) / 2);
                    if (tail[mid] <= num) {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                tail[l] = num;
            }
        }
        ans += sub.length - tail.length;
    }

    return ans;
};