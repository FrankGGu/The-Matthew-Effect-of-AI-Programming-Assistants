function longestOnes(A, K) {
    let left = 0;
    let maxLen = 0;
    let zeroCount = 0;

    for (let right = 0; right < A.length; right++) {
        if (A[right] === 0) {
            zeroCount++;
        }

        while (zeroCount > K) {
            if (A[left] === 0) {
                zeroCount--;
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}