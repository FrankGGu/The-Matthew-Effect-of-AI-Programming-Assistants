function longestDecomposition(text) {
    let left = 0, right = text.length - 1;
    let count = 0;

    while (left <= right) {
        let len = 1;
        while (left + len - 1 <= right && text.substr(left, len) === text.substr(right - len + 1, len)) {
            len++;
        }
        if (len === 1) break;
        count += 2;
        left += len - 1;
        right -= len - 1;
    }

    return count + (left === right ? 1 : 0);
}