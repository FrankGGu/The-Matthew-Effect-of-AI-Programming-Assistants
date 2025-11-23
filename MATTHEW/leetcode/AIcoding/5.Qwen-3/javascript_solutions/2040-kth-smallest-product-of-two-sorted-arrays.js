function kthSmallestProduct(A, B, k) {
    function countLessEqual(x) {
        let count = 0;
        let j = B.length - 1;
        for (let i = 0; i < A.length; ++i) {
            if (A[i] < 0) {
                while (j >= 0 && A[i] * B[j] > x) --j;
                count += j + 1;
            } else if (A[i] > 0) {
                while (j >= 0 && A[i] * B[j] > x) --j;
                count += B.length - j - 1;
            } else {
                if (x >= 0) count += B.length;
            }
        }
        return count;
    }

    let left = -1e10, right = 1e10;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (countLessEqual(mid) < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}