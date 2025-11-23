function transformArray(arr) {
    let result = arr.slice();
    let changed = true;

    while (changed) {
        changed = false;
        let temp = result.slice();

        for (let i = 0; i < arr.length; i++) {
            if (arr[i] === 0) continue;

            let count = 0;
            if (i > 0 && arr[i - 1] === arr[i]) count++;
            if (i < arr.length - 1 && arr[i + 1] === arr[i]) count++;

            if (count < 2) {
                temp[i] = arr[i] + 1;
                changed = true;
            }
        }

        result = temp;
        arr = result.slice();
    }

    return result;
}