function flip(arr, k) {
    let left = 0;
    let right = k - 1;
    while (left < right) {
        [arr[left], arr[right]] = [arr[right], arr[left]];
        left++;
        right--;
    }
}

function pancakeSort(arr) {
    const n = arr.length;
    const result = [];

    for (let i = n; i >= 1; i--) {
        let maxIdx = -1;
        for (let j = 0; j < i; j++) {
            if (arr[j] === i) {
                maxIdx = j;
                break;
            }
        }

        if (maxIdx === i - 1) {
            continue;
        }

        if (maxIdx !== 0) {
            flip(arr, maxIdx + 1);
            result.push(maxIdx + 1);
        }

        flip(arr, i);
        result.push(i);
    }

    return result;
}