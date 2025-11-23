function countSymmetricIntegers(nums) {
    function isSymmetric(num) {
        const str = num.toString();
        const len = str.length;
        for (let i = 0; i < len / 2; i++) {
            if (str[i] !== str[len - 1 - i]) {
                return false;
            }
        }
        return true;
    }

    let count = 0;
    for (const num of nums) {
        if (isSymmetric(num)) {
            count++;
        }
    }
    return count;
}