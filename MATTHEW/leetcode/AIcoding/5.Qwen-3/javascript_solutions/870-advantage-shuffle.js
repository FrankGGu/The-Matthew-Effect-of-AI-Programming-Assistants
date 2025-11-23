function advantageCount(C, R) {
    const sortedC = C.slice().sort((a, b) => a - b);
    const sortedR = R.slice().sort((a, b) => a - b);

    const map = new Map();
    for (let i = 0; i < R.length; i++) {
        map.set(R[i], (map.get(R[i]) || 0) + 1);
    }

    const result = [];
    let left = 0;
    let right = R.length - 1;

    for (let i = sortedR.length - 1; i >= 0; i--) {
        if (sortedC[right] > sortedR[i]) {
            result.unshift(sortedC[right]);
            right--;
        } else {
            result.unshift(sortedC[left]);
            left++;
        }
    }

    return result;
}