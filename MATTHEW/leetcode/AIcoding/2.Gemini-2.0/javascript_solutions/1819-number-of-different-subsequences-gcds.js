var countDifferentSubsequenceGCDs = function(nums) {
    const maxNum = Math.max(...nums);
    const present = new Array(maxNum + 1).fill(false);
    for (const num of nums) {
        present[num] = true;
    }

    let count = 0;
    for (let i = 1; i <= maxNum; i++) {
        let gcd = 0;
        for (let j = i; j <= maxNum; j += i) {
            if (present[j]) {
                if (gcd === 0) {
                    gcd = j;
                } else {
                    gcd = findGCD(gcd, j);
                }
            }
        }
        if (gcd === i) {
            count++;
        }
    }

    return count;

    function findGCD(a, b) {
        while (b) {
            const temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};