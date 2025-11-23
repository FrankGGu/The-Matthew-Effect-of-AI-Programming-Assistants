var findRestaurant = function(list1, list2) {
    const indexMap = new Map();
    const result = [];
    let minIndexSum = Infinity;

    for (let i = 0; i < list1.length; i++) {
        indexMap.set(list1[i], i);
    }

    for (let j = 0; j < list2.length; j++) {
        if (indexMap.has(list2[j])) {
            const indexSum = j + indexMap.get(list2[j]);
            if (indexSum < minIndexSum) {
                minIndexSum = indexSum;
                result.length = 0;
                result.push(list2[j]);
            } else if (indexSum === minIndexSum) {
                result.push(list2[j]);
            }
        }
    }

    return result;
};