function getNumberOfBacklogCards(height) {
    const n = height.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        if (height[i] < height[i - 1]) {
            left[i] = left[i - 1] + 1;
        } else {
            left[i] = 0;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (height[i] > height[i + 1]) {
            right[i] = right[i + 1] + 1;
        } else {
            right[i] = 0;
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result += left[i] + right[i];
    }

    return result;
}