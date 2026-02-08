var minimumIncrements = function(nums, k) {
    let res = 0;
    let arr = [];
    for (let num of nums) {
        if (num % k !== 0) {
            arr.push(k - (num % k));
        }
    }

    arr.sort((a, b) => a - b);

    while (arr.length > 0) {
        if (arr.length >= 3) {
            res += Math.min(arr[0], k - arr[0]);
            if (arr[0] < k - arr[0]) {
              arr.shift();
            } else {
              arr = arr.map(x => x - (k - arr[0])).filter(x => x > 0);
              arr.sort((a, b) => a - b);
            }

        } else if (arr.length === 2) {
            res += Math.min(arr[0], k - arr[0]);
            if (arr[0] < k - arr[0]) {
              arr.shift();
            } else {
              arr = arr.map(x => x - (k - arr[0])).filter(x => x > 0);
              arr.sort((a, b) => a - b);
            }
        } else {
            res += Math.min(arr[0], k - arr[0]);
            arr.shift();
        }
    }

    return res;
};