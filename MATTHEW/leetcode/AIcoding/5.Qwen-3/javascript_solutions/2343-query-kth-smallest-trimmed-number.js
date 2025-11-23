function sumOfEncryptedInt(nums) {
    return nums.reduce((total, num) => {
        const str = num.toString();
        const min = Math.min(...str.split('').map(Number));
        const max = Math.max(...str.split('').map(Number));
        return total + (max - min);
    }, 0);
}