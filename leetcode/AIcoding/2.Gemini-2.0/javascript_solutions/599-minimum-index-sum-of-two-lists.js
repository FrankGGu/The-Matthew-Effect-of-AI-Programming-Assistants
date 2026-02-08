var findRestaurant = function(list1, list2) {
    const map1 = new Map();
    for (let i = 0; i < list1.length; i++) {
        map1.set(list1[i], i);
    }

    let minSum = Infinity;
    const result = [];

    for (let i = 0; i < list2.length; i++) {
        if (map1.has(list2[i])) {
            const sum = i + map1.get(list2[i]);
            if (sum < minSum) {
                minSum = sum;
                result.length = 0;
                result.push(list2[i]);
            } else if (sum === minSum) {
                result.push(list2[i]);
            }
        }
    }

    return result;
};