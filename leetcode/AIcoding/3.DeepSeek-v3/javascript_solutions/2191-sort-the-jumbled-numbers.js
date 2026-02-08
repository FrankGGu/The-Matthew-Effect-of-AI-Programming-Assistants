var sortJumbled = function(mapping, nums) {
    const mappedNums = nums.map(num => {
        let str = num.toString();
        let mappedStr = '';
        for (let c of str) {
            mappedStr += mapping[parseInt(c)];
        }
        return {
            original: num,
            mapped: parseInt(mappedStr)
        };
    });

    mappedNums.sort((a, b) => {
        if (a.mapped === b.mapped) {
            return nums.indexOf(a.original) - nums.indexOf(b.original);
        }
        return a.mapped - b.mapped;
    });

    return mappedNums.map(item => item.original);
};