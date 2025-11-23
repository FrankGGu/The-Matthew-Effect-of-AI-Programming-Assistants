var oddEvenJumps = function(arr) {
    const n = arr.length;
    let odd = new Array(n).fill(false);
    let even = new Array(n).fill(false);
    odd[n - 1] = true;
    even[n - 1] = true;
    let map = new Map();
    map.set(arr[n - 1], n - 1);
    let ans = 1;

    for (let i = n - 2; i >= 0; i--) {
        let ceiling = null;
        let floor = null;

        for (let [key, value] of map) {
            if (key >= arr[i]) {
                if (ceiling === null || key < ceiling[0]) {
                    ceiling = [key, value];
                }
            }
            if (key <= arr[i]) {
                if (floor === null || key > floor[0]) {
                    floor = [key, value];
                }
            }
        }

        if (ceiling !== null) {
            odd[i] = even[ceiling[1]];
        }
        if (floor !== null) {
            even[i] = odd[floor[1]];
        }

        if (odd[i]) {
            ans++;
        }

        map.set(arr[i], i);
    }

    return ans;
};