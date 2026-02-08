var findNumberOfCopyArrays = function(nums) {
    let copyCount = 0;
    const seenArrays = new Set();

    for (const arr of nums) {
        const arrString = JSON.stringify(arr);

        if (seenArrays.has(arrString)) {
            copyCount++;
        } else {
            seenArrays.add(arrString);
        }
    }

    return copyCount;
};