var longestOnes = function(A, K) {
    let left = 0, right = 0, zeroCount = 0, maxLength = 0;

    while (right < A.length) {
        if (A[right] === 0) zeroCount++;

        while (zeroCount > K) {
            if (A[left] === 0) zeroCount--;
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};