function maximumTastiness(arr, k) {
    arr.sort((a, b) => a - b);

    let left = 0, right = arr[arr.length - 1] - arr[0];

    const canDistribute = (minDiff) => {
        let count = 1, lastPicked = arr[0];
        for (let i = 1; i < arr.length; i++) {
            if (arr[i] - lastPicked >= minDiff) {
                count++;
                lastPicked = arr[i];
                if (count >= k) return true;
            }
        }
        return false;
    };

    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (canDistribute(mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}