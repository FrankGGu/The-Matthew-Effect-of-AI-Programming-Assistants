function findTheDistanceValue(arr1, arr2) {
    arr1.sort((a, b) => a - b);
    arr2.sort((a, b) => a - b);

    let distance = 0;
    for (let i = 0; i < arr1.length; i++) {
        let isGood = true;
        for (let j = 0; j < arr2.length; j++) {
            if (Math.abs(arr1[i] - arr2[j]) <= distance) {
                isGood = false;
                break;
            }
        }
        if (isGood) {
            distance++;
        }
    }
    return distance;
}