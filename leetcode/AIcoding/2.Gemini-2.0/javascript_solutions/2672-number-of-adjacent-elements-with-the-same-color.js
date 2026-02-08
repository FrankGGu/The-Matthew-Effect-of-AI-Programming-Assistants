var colorTheArray = function(n, queries) {
    const arr = new Array(n).fill(0);
    const ans = [];
    let count = 0;

    for (const [index, color] of queries) {
        if (arr[index] !== 0) {
            if (index > 0 && arr[index - 1] === arr[index]) {
                count--;
            }
            if (index < n - 1 && arr[index + 1] === arr[index]) {
                count--;
            }
        }

        arr[index] = color;

        if (index > 0 && arr[index - 1] === arr[index]) {
            count++;
        }
        if (index < n - 1 && arr[index + 1] === arr[index]) {
            count++;
        }

        ans.push(count);
    }

    return ans;
};