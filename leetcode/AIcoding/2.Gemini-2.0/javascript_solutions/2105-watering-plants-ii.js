var wateringPlants = function(plants, capacityA, capacityB) {
    let n = plants.length;
    let a = capacityA;
    let b = capacityB;
    let ans = 0;
    let i = 0;
    let j = n - 1;

    while (i < j) {
        if (a < plants[i]) {
            a = capacityA;
            ans++;
        }
        a -= plants[i];
        i++;

        if (b < plants[j]) {
            b = capacityB;
            ans++;
        }
        b -= plants[j];
        j--;
    }

    if (i === j) {
        if (a >= b) {
            if (a < plants[i]) {
                ans++;
            }
        } else {
            if (b < plants[i]) {
                ans++;
            }
        }
    }

    return ans;
};