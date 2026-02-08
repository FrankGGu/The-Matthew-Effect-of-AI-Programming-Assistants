var pancakeSort = function(A) {
    const result = [];
    const n = A.length;

    const flip = (k) => {
        let left = 0;
        let right = k;
        while (left < right) {
            [A[left], A[right]] = [A[right], A[left]];
            left++;
            right--;
        }
    };

    for (let size = n; size > 1; size--) {
        let maxIndex = A.indexOf(Math.max(...A.slice(0, size)));
        if (maxIndex !== size - 1) {
            if (maxIndex !== 0) {
                flip(maxIndex);
                result.push(maxIndex + 1);
            }
            flip(size - 1);
            result.push(size);
        }
    }

    return result;
};