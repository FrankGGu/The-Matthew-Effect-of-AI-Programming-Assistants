var findRadius = function(houses, heaters) {
    heaters.sort((a, b) => a - b);
    let maxRadius = 0;

    for (let house of houses) {
        let left = 0;
        let right = heaters.length - 1;
        let minRadius = Infinity;

        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            let radius = Math.abs(heaters[mid] - house);

            minRadius = Math.min(minRadius, radius);

            if (heaters[mid] < house) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (right >= 0) {
          minRadius = Math.min(minRadius, Math.abs(heaters[right] - house));
        }
        if (left < heaters.length) {
          minRadius = Math.min(minRadius, Math.abs(heaters[left] - house));
        }

        maxRadius = Math.max(maxRadius, minRadius);
    }

    return maxRadius;
};