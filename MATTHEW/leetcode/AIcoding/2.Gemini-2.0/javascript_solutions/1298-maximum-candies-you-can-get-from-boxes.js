var maxCandies = function(boxes, candies, keys, containedBoxes, initialBoxes) {
    let hasBox = new Array(boxes.length).fill(false);
    let hasKey = new Array(boxes.length).fill(false);
    let q = [];
    let ans = 0;

    for (let box of initialBoxes) {
        hasBox[box] = true;
        q.push(box);
    }

    while (q.length > 0) {
        let box = q.shift();
        ans += candies[box];

        for (let key of keys[box]) {
            hasKey[key] = true;
            if (hasBox[key] === false) {
                hasBox[key] = true;
                q.push(key);
            }
        }

        for (let containedBox of containedBoxes[box]) {
            if (hasBox[containedBox] === false) {
                if (hasKey[containedBox] === true) {
                    hasBox[containedBox] = true;
                    q.push(containedBox);
                } else {
                    hasBox[containedBox] = true;
                }
            }
        }
    }

    return ans;
};