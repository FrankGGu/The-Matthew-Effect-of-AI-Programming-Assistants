var smallestNumber = function(num) {
    if (num === 0) {
        return 0;
    }

    const isNegative = num < 0;
    let s = String(Math.abs(num));
    let arr = Array.from(s);

    if (isNegative) {
        // For negative numbers, we want the largest absolute value to make it the smallest negative number.
        // This means sorting digits in descending order.
        arr.sort((a, b) => b.localeCompare(a));
        return -parseInt(arr.join(''));
    } else {
        // For positive numbers, we want the smallest number.
        // Sort digits in ascending order.
        arr.sort((a, b) => a.localeCompare(b));

        // Handle leading zeros: find the first non-zero digit and swap it with the first digit (which is '0').
        if (arr[0] === '0') {
            let firstNonZeroIndex = -1;
            for (let i = 0; i < arr.length; i++) {
                if (arr[i] !== '0') {
                    firstNonZeroIndex = i;
                    break;
                }
            }
            // If there are non-zero digits, swap the first '0' with the first non-zero digit.
            if (firstNonZeroIndex !== -1) {
                [arr[0], arr[firstNonZeroIndex]] = [arr[firstNonZeroIndex], arr[0]];
            }
            // If all digits are '0', it means the original number was 0, which is handled at the beginning.
            // Or if it was like '000', it will remain '000' and parseInt will correctly make it 0.
        }
        return parseInt(arr.join(''));
    }
};