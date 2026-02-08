var longestDiverseString = function(a, b, c) {
    let result = "";
    let arr = [[a, 'a'], [b, 'b'], [c, 'c']];

    while (true) {
        arr.sort((x, y) => y[0] - x[0]);

        let canAdd = false;
        for (let i = 0; i < 3; i++) {
            if (arr[i][0] <= 0) break;

            if (result.length >= 2 && result[result.length - 1] === arr[i][1] && result[result.length - 2] === arr[i][1]) {
                continue;
            }

            result += arr[i][1];
            arr[i][0]--;
            canAdd = true;
            break;
        }

        if (!canAdd) break;
    }

    return result;
};