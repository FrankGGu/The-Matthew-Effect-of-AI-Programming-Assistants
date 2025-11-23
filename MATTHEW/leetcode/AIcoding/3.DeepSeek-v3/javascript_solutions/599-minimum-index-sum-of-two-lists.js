var findRestaurant = function(list1, list2) {
    const map = new Map();
    for (let i = 0; i < list1.length; i++) {
        map.set(list1[i], i);
    }

    let result = [];
    let minSum = Infinity;

    for (let j = 0; j < list2.length; j++) {
        if (map.has(list2[j])) {
            const sum = j + map.get(list2[j]);
            if (sum < minSum) {
                result = [list2[j]];
                minSum = sum;
            } else if (sum === minSum) {
                result.push(list2[j]);
            }
        }
    }

    return result;
};