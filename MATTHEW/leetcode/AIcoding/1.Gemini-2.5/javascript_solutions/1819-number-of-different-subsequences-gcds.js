var numberOfDifferentSubsequencesGCDs = function(nums) {
    const maxVal = Math.max(...nums);
    const isPresent = new Array(maxVal + 1).fill(false);
    for (const num of nums) {
        isPresent[num] = true;
    }

    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let count = 0;
    for (let g = 1; g <= maxVal; g++) {
        let currentGcdForG = 0;
        for (let multiple = g; multiple <= maxVal; multiple += g) {
            if (isPresent[multiple]) {
                currentGcdForG = gcd(currentGcdForG, multiple);
                if (currentGcdForG === g) {
                    break; 
                }
            }
        }
        if (currentGcdForG === g) {
            count++;
        }
    }

    return count;
};