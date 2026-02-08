var findRestaurant = function(list1, list2) {
    const map1 = new Map();
    for (let i = 0; i < list1.length; i++) {
        map1.set(list1[i], i);
    }

    let minSum = Infinity;
    let result = [];

    for (let j = 0; j < list2.length; j++) {
        const restaurant = list2[j];
        if (map1.has(restaurant)) {
            const i = map1.get(restaurant);
            const currentSum = i + j;

            if (currentSum < minSum) {
                minSum = currentSum;
                result = [restaurant];
            } else if (currentSum === minSum) {
                result.push(restaurant);
            }
        }
    }

    return result;
};