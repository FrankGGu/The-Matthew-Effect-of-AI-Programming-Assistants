function countPoints(points, cars) {
    let result = Array(cars.length).fill(0);

    for (let [x, y] of points) {
        for (let i = 0; i < cars.length; i++) {
            const [cx, cy, r] = cars[i];
            if ((x - cx) ** 2 + (y - cy) ** 2 <= r ** 2) {
                result[i]++;
            }
        }
    }

    return result;
}