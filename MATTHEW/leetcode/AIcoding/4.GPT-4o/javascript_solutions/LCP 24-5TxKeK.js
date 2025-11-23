function game(nums) {
    let sum = nums.reduce((a, b) => a + b, 0);
    return sum % 2 === 0 ? 'Alice' : 'Bob';
}