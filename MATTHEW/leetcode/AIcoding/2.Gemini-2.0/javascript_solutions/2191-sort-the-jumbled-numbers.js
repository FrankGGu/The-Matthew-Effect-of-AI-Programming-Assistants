var sortJumbled = function(mapping, nums) {
    const transformed = nums.map(num => {
        const str = String(num);
        let mappedStr = "";
        for (let i = 0; i < str.length; i++) {
            mappedStr += String(mapping[parseInt(str[i])]);
        }
        return { original: num, mapped: parseInt(mappedStr) || 0 };
    });

    transformed.sort((a, b) => a.mapped - b.mapped);

    return transformed.map(item => item.original);
};