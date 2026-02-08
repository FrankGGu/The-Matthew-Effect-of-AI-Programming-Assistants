var subarraysWithKDistinct = function(A, K) {
    const atMostK = (K) => {
        const count = new Map();
        let res = 0, left = 0;
        for (let right = 0; right < A.length; right++) {
            if (count.get(A[right]) === undefined) {
                count.set(A[right], 0);
            }
            count.set(A[right], count.get(A[right]) + 1);
            while (count.size > K) {
                count.set(A[left], count.get(A[left]) - 1);
                if (count.get(A[left]) === 0) {
                    count.delete(A[left]);
                }
                left++;
            }
            res += right - left + 1;
        }
        return res;
    };

    return atMostK(K) - atMostK(K - 1);
};