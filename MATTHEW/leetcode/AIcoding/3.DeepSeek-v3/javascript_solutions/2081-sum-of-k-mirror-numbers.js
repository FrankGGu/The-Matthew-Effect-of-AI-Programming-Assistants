var kMirror = function(k, n) {
    let sum = 0;
    let count = 0;
    let num = 1;

    const isMirror = (s) => {
        let left = 0;
        let right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    };

    while (count < n) {
        const numStr = num.toString();
        if (isMirror(numStr)) {
            const kStr = num.toString(k);
            if (isMirror(kStr)) {
                sum += num;
                count++;
            }
        }
        num++;
    }

    return sum;
};