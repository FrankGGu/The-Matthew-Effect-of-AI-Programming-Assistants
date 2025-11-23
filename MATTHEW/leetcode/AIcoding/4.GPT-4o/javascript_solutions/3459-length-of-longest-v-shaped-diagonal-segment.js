var longestVShapedSegment = function(A) {
    let n = A.length;
    let maxLen = 0;

    for (let i = 0; i < n; i++) {
        let length = 1;

        for (let j = i; j < n - 1; j++) {
            if (A[j] > A[j + 1]) {
                length++;
            } else {
                break;
            }
        }

        for (let j = i + length - 1; j < n - 1; j++) {
            if (A[j] < A[j + 1]) {
                length++;
            } else {
                break;
            }
        }

        maxLen = Math.max(maxLen, length);
    }

    return maxLen;
};