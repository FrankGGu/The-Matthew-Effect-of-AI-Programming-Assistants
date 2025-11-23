var makeSimilar = function(nums, target) {
    const evenNums = nums.filter(num => num % 2 === 0).sort((a, b) => a - b);
    const oddNums = nums.filter(num => num % 2 !== 0).sort((a, b) => a - b);
    const evenTarget = target.filter(num => num % 2 === 0).sort((a, b) => a - b);
    const oddTarget = target.filter(num => num % 2 !== 0).sort((a, b) => a - b);

    let operations = 0;

    for (let i = 0; i < evenNums.length; i++) {
        operations += Math.abs(evenNums[i] - evenTarget[i]) / 2;
    }

    for (let i = 0; i < oddNums.length; i++) {
        operations += Math.abs(oddNums[i] - oddTarget[i]) / 2;
    }

    return operations / 2;
};