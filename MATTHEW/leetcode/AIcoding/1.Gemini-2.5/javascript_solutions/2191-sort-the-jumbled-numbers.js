var sortJumbled = function(mapping, nums) {
    const jumbledData = [];

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const numStr = String(num);
        let jumbledStr = '';

        for (let j = 0; j < numStr.length; j++) {
            const digit = parseInt(numStr[j]);
            jumbledStr += mapping[digit];
        }

        const jumbledValue = parseInt(jumbledStr);
        jumbledData.push([jumbledValue, i, num]);
    }

    jumbledData.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1]; // Stable sort based on original index
    });

    const result = [];
    for (let i = 0; i < jumbledData.length; i++) {
        result.push(jumbledData[i][2]);
    }

    return result;
};