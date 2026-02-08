function minJumps(arr, n) {
    if (n <= 1) return 0;
    if (arr[0] === 0) return -1;

    let jumps = 1;
    let max_reach = arr[0];
    let steps = arr[0];

    for (let i = 1; i < n - 1; i++) {
        if (i > max_reach) return -1;
        steps--;
        if (arr[i] + i > max_reach) {
            max_reach = arr[i] + i;
        }
        if (steps === 0) {
            jumps++;
            steps = max_reach - i;
        }
    }

    return jumps;
}