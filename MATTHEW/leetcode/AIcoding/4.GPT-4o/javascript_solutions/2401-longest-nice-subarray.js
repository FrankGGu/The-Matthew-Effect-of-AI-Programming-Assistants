var longestNiceSubarray = function(A) {
    let left = 0, maxLength = 0, currMask = 0;
    for (let right = 0; right < A.length; right++) {
        while ((currMask & A[right]) !== 0) {
            currMask ^= A[left];
            left++;
        }
        currMask |= A[right];
        maxLength = Math.max(maxLength, right - left + 1);
    }
    return maxLength;
};