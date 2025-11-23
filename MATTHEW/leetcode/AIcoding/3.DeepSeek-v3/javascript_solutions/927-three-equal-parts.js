var threeEqualParts = function(arr) {
    const countOnes = arr.reduce((sum, num) => sum + num, 0);
    if (countOnes % 3 !== 0) return [-1, -1];
    if (countOnes === 0) return [0, 2];

    const targetOnes = countOnes / 3;
    let firstEnd = 0, secondEnd = 0, thirdEnd = 0;
    let count = 0;

    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === 1) {
            count++;
            if (count === 1) firstEnd = i;
            if (count === targetOnes + 1) secondEnd = i;
            if (count === 2 * targetOnes + 1) thirdEnd = i;
        }
    }

    const part1 = arr.slice(firstEnd, secondEnd);
    const part2 = arr.slice(secondEnd, thirdEnd);
    const part3 = arr.slice(thirdEnd);

    if (part1.length > part3.length || part2.length > part3.length) {
        return [-1, -1];
    }

    const len = part3.length;
    if (part1.length < len) {
        const zerosToAdd = len - part1.length;
        part1.push(...new Array(zerosToAdd).fill(0));
    }
    if (part2.length < len) {
        const zerosToAdd = len - part2.length;
        part2.push(...new Array(zerosToAdd).fill(0));
    }

    for (let i = 0; i < len; i++) {
        if (part1[i] !== part3[i] || part2[i] !== part3[i]) {
            return [-1, -1];
        }
    }

    return [firstEnd + len - 1, secondEnd + len];
};