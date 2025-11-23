function separateDigits(nums) {
    const result = [];
    for (const num of nums) {
        const digits = String(num).split('');
        for (const digit of digits) {
            result.push(Number(digit));
        }
    }
    return result;
}