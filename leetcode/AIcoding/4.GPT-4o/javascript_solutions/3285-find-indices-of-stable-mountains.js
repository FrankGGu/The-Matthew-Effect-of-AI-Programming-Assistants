function findStableMountains(arr) {
    let indices = [];
    for (let i = 1; i < arr.length - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            indices.push(i);
        }
    }
    return indices;
}