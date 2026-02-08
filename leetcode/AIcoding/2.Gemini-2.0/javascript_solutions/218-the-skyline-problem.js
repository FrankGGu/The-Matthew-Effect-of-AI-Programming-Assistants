var getSkyline = function(buildings) {
    let events = [];
    for (let i = 0; i < buildings.length; i++) {
        events.push([buildings[i][0], -buildings[i][2]]);
        events.push([buildings[i][1], buildings[i][2]]);
    }
    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return a[1] - b[1];
        }
    });

    let result = [];
    let heightMap = new Map();
    heightMap.set(0, 1);
    let currentHeight = 0;

    for (let event of events) {
        let x = event[0];
        let height = event[1];

        if (height < 0) {
            height = -height;
            heightMap.set(height, (heightMap.get(height) || 0) + 1);
        } else {
            if (heightMap.get(height) === 1) {
                heightMap.delete(height);
            } else {
                heightMap.set(height, heightMap.get(height) - 1);
            }
        }

        let maxHeight = 0;
        for (let key of heightMap.keys()) {
            maxHeight = Math.max(maxHeight, key);
        }

        if (maxHeight !== currentHeight) {
            result.push([x, maxHeight]);
            currentHeight = maxHeight;
        }
    }

    return result;
};