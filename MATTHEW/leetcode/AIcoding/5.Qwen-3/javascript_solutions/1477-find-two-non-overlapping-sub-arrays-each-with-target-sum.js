function minTotalCost(arr, target) {
    const n = arr.length;
    const left = new Array(n).fill(Infinity);
    const right = new Array(n).fill(Infinity);

    let sum = 0;
    let j = 0;
    for (let i = 0; i < n; i++) {
        sum += arr[i];
        while (sum > target) {
            sum -= arr[j];
            j++;
        }
        if (sum === target) {
            left[i] = i - j + 1;
        }
        if (i > 0) {
            left[i] = Math.min(left[i], left[i - 1]);
        }
    }

    sum = 0;
    j = n - 1;
    for (let i = n - 1; i >= 0; i--) {
        sum += arr[i];
        while (sum > target) {
            sum -= arr[j];
            j--;
        }
        if (sum === target) {
            right[i] = j - i + 1;
        }
        if (i < n - 1) {
            right[i] = Math.min(right[i], right[i + 1]);
        }
    }

    let result = Infinity;
    for (let i = 0; i < n - 1; i++) {
        if (left[i] !== Infinity && right[i + 1] !== Infinity) {
            result = Math.min(result, left[i] + right[i + 1]);
        }
    }

    return result;
}