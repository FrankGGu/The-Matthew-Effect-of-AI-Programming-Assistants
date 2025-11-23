var longestMountain = function(A) {
    let maxLength = 0;
    const n = A.length;

    for (let i = 1; i < n - 1; i++) {
        if (A[i] > A[i - 1] && A[i] > A[i + 1]) {
            let left = i, right = i;

            while (left > 0 && A[left - 1] < A[left]) {
                left--;
            }
            while (right < n - 1 && A[right + 1] < A[right]) {
                right++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength;
};