var trafficLight = function(road, n) {
    let currentRoad = road.split('');
    const result = [];
    for (let i = 0; i <= n; i++) {
        const snapshot = currentRoad.join('');
        result.push(snapshot);
        if (i === n) break;
        let newRoad = [...currentRoad];
        for (let j = 0; j < currentRoad.length; j++) {
            if (currentRoad[j] === 'G') {
                if (j + 1 < currentRoad.length && currentRoad[j + 1] === '.') {
                    newRoad[j] = '.';
                    newRoad[j + 1] = 'G';
                }
            } else if (currentRoad[j] === 'R') {
                if (j - 1 >= 0 && currentRoad[j - 1] === '.') {
                    newRoad[j] = '.';
                    newRoad[j - 1] = 'R';
                }
            }
        }
        currentRoad = newRoad;
    }
    return result;
};